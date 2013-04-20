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
    // /api/user/login/photacon?email=howard0010@yahoo.com&&password=52012345
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
    case  "register" :: "photacon" :: Nil Get _ => {
      for {
        email <- S.param("email") ?~ "Missing email" ~> 400
        password <- S.param("password") ?~ "Missing password" ~> 400
        user <- UserModel.createByEmail(email) ~> 400
      } yield {
        user.email.set(email)
        user.password.set(password)
        UserModel.logUserIn(user);
        RestFormatters.toJSON(user.saveMe)
      }
    }
    //  http://localhost:8080/api/user/add/facebook?email=howard0010@yahoo.com&&token=api/user/add/facebook?email=howard0010@yahoo.com&&accessTokem=AAACEdEose0cBAIeF9f3D0jg5fYMnSKvioxsrn6hvd6ZAw8N11fxxpEjG1WGanIZAhBqowpGWbUjZBuKMxi33ZApZBoM6EMRthJuKeOTbqJQZDZD
    case "add" :: plugin :: Nil Get _ => {
      for {
        pluginValue <- Plugins.values.find(_.toString == plugin) ?~ "App not supported" ~> 400
        user <- UserModel.currentUser ?~ "Please login" ~> 401
        accessToken <- S.param("token") ?~ "Missing token" ~> 400
        email <- S.param("email") ?~ "Missing email" ~> 400
        if PluginManager.verifyToken(accessToken,pluginValue)
      } yield {
        var account = AccountModel.create.user(user).accessToken(accessToken)
          .email(email).plugin(pluginValue)
        PluginManager.initAccount(account,pluginValue)
        account.save
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
        RestFormatters.toJSON(user) ~
        ("new" -> false)
      }
      case Empty => {
        JsonResponse(("new" -> true))
      }
      case Failure(msg, _, _) => JsonResponse(("fail to post token"), 401)
    }
  }
}