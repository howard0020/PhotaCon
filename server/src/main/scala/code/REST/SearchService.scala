package code.REST;

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._
import code.model._
import net.liftweb.http.S
import RestFormatters._


object SearchService extends RestHelper {
  serve("api" / "search" prefix {
    //  /api/search/users?name=howard
    case "users" :: Nil Get _ => {
      for {
        user <- UserModel.currentUser ?~ "Please login" ~> 400
        name <- S.param("name") ?~ "Missing name" ~> 400
      } yield {
        val users = UserModel.findUserByName(name)
        formatUsers(user,users)
      }
	  }
	})
  def formatUsers(currUser: UserModel,users:List[UserModel]):JValue = {
    val result = for (user <- users) yield {
      ("user" ->
        ("id" -> restId(user)) ~
          ("email" -> user.email.is) ~
          ("firstName" -> user.firstName.is) ~
          ("lastName" -> user.lastName.is) ~
          ("accounts" -> user.accounts.map(account=>isConnectedJSON(currUser,account))))
    }
   // Console.println(result)
    result
  }
  def isConnectedJSON(currUser: UserModel,account: AccountModel): JObject = {
    val currAccount = currUser.findAccount(account.plugin)
    RestFormatters.toJSON(account) ~
    ("isConnected" -> PluginManager.isConnected(currAccount.openOr(null),account).toOption)
  }
}
