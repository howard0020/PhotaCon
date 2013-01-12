package code.REST

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._


object LoginService extends RestHelper {
	serve("api" / "login" prefix {
    case "user" :: Nil Get _ => {
      for {
        email <- S.param("email") ?~ "Missing email" ~> 400
        password <- S.param("password") ?~ "Missing password" ~> 400
      }yield ("email" -> "howard0020@yahoo.com") ~ ("id" -> "1")
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
	  case "channel" :: plugin ::  Nil JsonGet _ => {
		  Console.println("===>channel")
		  JString("<script src=\"//connect.facebook.net/en_US/all.js\"></script>")	      
	  }
  	  case "channel" :: plugin ::  Nil JsonPost _ => {
  	    Console.println("===>channel")
		  JString("<script src=\"//connect.facebook.net/en_US/all.js\"></script>")	      
	  }
	})
}