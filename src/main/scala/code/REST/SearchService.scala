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

object SearchService extends RestHelper{
	serve("api" / "search" prefix{
    //  /api/search/users?name=howard
	  case "users" :: Nil Get _ => {
      for{
        name <- S.param("name") ?~ "Missing name" ~> 400
      }yield{
        val users = UserModel.findUserByName(name)
        toJSONList(users)
      }
	  }
	})

  def toJSONList(users: List[UserModel]): JValue = {
    users.map(user => toJSON(user))
  }
}
