package code.REST

import net.liftweb._
import http._
import http.rest._
import json._
import code.plugin.PluginManager
import common._
import JsonDSL._
import code.model._
import net.liftweb.http.S

/**
 * Created with IntelliJ IDEA.
 * User: chenghaolin
 * Date: 1/12/13
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
object TestService extends RestHelper{
    serve("api" / "test" prefix {
      case "login" :: "failure" :: Nil Get _ => {
        JsonResponse(("fail to login"),Nil,Nil,401)
      }
      case "inspect" :: "session" :: Nil Get _ => {
        for {
          session <- S.session ?~ "sesson not found"
        }yield JString(session.uniqueId)
      }
    })
}
