package code.REST

import net.liftweb._
import http._
import rest._
import json._

object HomeContentService extends RestHelper {
	serve {
	  case "api" :: "homePage" :: "content" :: Nil JsonGet _ => JString("Hello World!")
	}
}