package code.REST

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._

/**
 * Created with IntelliJ IDEA.
 * User: chenghaolin
 * Date: 1/12/13
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
object TestService extends RestHelper{
    serve("api" / "test" prefix {
      case Req("login" :: "failure" :: Nil,_,GetRequest) => {
        JsonResponse(("fail to login"),Nil,Nil,401)
      }
    })
}
