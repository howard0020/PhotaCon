package code.REST

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._
import code.model._
import code.plugin._
import Box._

object LoginService extends RestHelper {
  serve("api" / "user" / "login" prefix {
    //login a user in PhotaCon
    case "photacon" :: Nil Get _ => {
      for {
        email <- S.param("email") ?~ "Missing email" ~> 400
        password <- S.param("password") ?~ "Missing password" ~> 400
        user <- UserModel.findUserByEmail(email) ?~ "user not found"
        if user.password.match_?(password)
      } yield {
        UserModel.logUserIn(user)
        RestFormatters.toJSON(user)
      }
    }
    // /api/user/login/post/accessToken/facebook?email=howard0020@yahoo.com&&token=AAACEdEose0cBACnbmm8TE6FKv8n7reZCESejPrw4oahoZBl3ZCoBZATlF2TSYv9nkR3EJJRSZAKEPytuNEOPksThRkfc5uFOJaVrrNGVbZAQZDZD
    case "post" :: "accessToken" :: plugin :: Nil Get _ => {
      for {
        pluginValue <- Plugins.values.find(_.toString == plugin) ?~ "App not supported" ~> 400
        email <- S.param("email") ?~ "Missing email" ~> 400
        accessToken <- S.param("token") ?~ "Missing token" ~> 400
        if PluginManager.verifyToken(accessToken,pluginValue)
      } yield {
        postToken(email, pluginValue, accessToken)
      }
    }
    case "url" :: plugin :: Nil JsonGet _ => {
      var loginManager = PluginManager.getLoginManager(plugin)
      var url = loginManager.getAuthUrl()
      JString(url)
    }
  })
  serve("api" / "user" prefix {
    case "register" :: Nil Get _ => {
      for {
        email <- S.param("email") ?~ "Missing email" ~> 400
        password <- S.param("password") ?~ "Missing password" ~> 400
        user <- UserModel.createByEmail(email) ~> 401
      } yield {
        user.email.set(email)
        user.password.set(password)
        UserModel.logUserIn(user);
        RestFormatters.toJSON(user.saveMe)
      }
    }
  })
  def postToken(email: String, pluginValue: Plugins.Value, accessToken: String): LiftResponse = {
    var account = AccountModel.findAccountByEmailPlugin(email, pluginValue)
    account match {
      case Full(act) => {
        act.accessToken(accessToken)
        act.save
        var user = act.user.obj.openOrThrowException("Found account without user")
        UserModel.logUserIn(user)
        RestFormatters.toJSON(user)
      }
      case Empty => {
        var user = UserModel.create.email(email)
        var account = AccountModel.create.user(user).accessToken(accessToken)
          .email(email).plugin(pluginValue)
        account.save
        PluginManager.initAccount(account,pluginValue)
        user.accounts += account
        UserModel.logUserIn(user)
        RestFormatters.toJSON(user.saveMe)
      }
      case Failure(msg, _, _) => JsonResponse(("fail to post token"), 401)
    }
  }
}