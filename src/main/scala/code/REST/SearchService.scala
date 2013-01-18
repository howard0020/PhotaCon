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

object SearchService extends RestHelper{
	serve("api" / "search" prefix{
	  case "users" :: Nil Get _ => {
	    JsonResponse(("fail to login"),Nil,Nil,401)
	  }
	})
}
