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
    case "users" :: Nil Get _ => {
      for {
        user <- UserModel.currentUser ?~ "Please login" ~> 400
        name <- S.param("name") ?~ "Missing name" ~> 400
      } yield {
        val users = UserModel.findUserByName(name)
        RestFormatters.toJSONList(users)
      }
    }
  })
  def formatUsers(user:UserModel) = {
    
  }
}
