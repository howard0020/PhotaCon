package code.REST

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._
import code.model.UserModel

object LoginService extends RestHelper {
	serve("api" / "user" / "login" prefix {
	  //login a user PhotaCon's credentials
    case "user" :: Nil Get _ => {
      for {
        email <- S.param("email") ?~ "Missing email" ~> 400
        password <- S.param("password") ?~ "Missing password" ~> 400
        user <- UserModel.findUserByEmail(email) ?~ "user not found"
        if user.password.match_?(password)
      }yield{
        UserModel.logUserIn(user)
        RestFormatters.toJSON(user)
      } 
    }
    
	  case "url" :: plugin :: Nil JsonGet _ => {
		  var loginManager = PluginManager.getLoginManager(plugin)
		  var url = loginManager.getAuthUrl()
		  JString(url)
	  }
	  case "success" :: "accessToken" :: plugin ::  Nil JsonGet _ => {
		  S.param("token") match {
		    case Full(token) => {
		      Console.println(token)	
		      JString("success")
		    }
		    case Empty => JString("Error - empty token")
		    case Failure(msg,_,_) => JString(msg)
		  }  
	  }
	})
	serve("api" / "user" prefix {
	  case "register" :: Nil Get _ => {
	     for {
	        email <- S.param("email") ?~ "Missing email" ~> 400
	        password <- S.param("password") ?~ "Missing password" ~> 400
	        user <- UserModel.createByEmail(email) ~> 401
	     }yield{
	        user.email.set(email)
	        user.password.set(password)
	        RestFormatters.toJSON(user.saveMe)
          UserModel.logUserIn(user);
	     }
	  }
	})
}