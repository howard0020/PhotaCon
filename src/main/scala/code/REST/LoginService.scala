package code.REST

import net.liftweb._
import http._
import rest._
import json._
import code.plugin.PluginManager
import common._

object LoginService extends RestHelper {
	serve {
	  case "api" :: "login" :: "url" :: plugin :: Nil JsonGet _ => {
		  var loginManager = PluginManager.getLoginManager(plugin)
		  JString(loginManager.getAuthUrl())
	  }
	  case "api" :: "login" :: "success" :: plugin ::  Nil JsonGet _ => {
		  var loginManager = PluginManager.getLoginManager(plugin)
		  var accessToken = loginManager.getAccessToken()
		  JString(accessToken)
	      
	  }
	}
}