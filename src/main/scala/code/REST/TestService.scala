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
import mapper._
import RestFormatters._
/**
 * Created with IntelliJ IDEA.
 * User: chenghaolin
 * Date: 1/12/13
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
object TestService extends RestHelper{
    serve("api" / "test" prefix {
      case "connected" :: email :: id :: Nil Get _ => {
        var user = UserModel.findUserByEmail(email) openOrThrowException("user not found")
        var manager = PluginManager.getLoginManager("facebook")
        var result = manager.isConnected(id,user.accounts(0))
        JString(result.toString())
      }
      case "login" :: "failure" :: Nil Get _ => {
        JsonResponse(("fail to login"),401)
      }
      case "inspect" :: "session" :: Nil Get _ => {
        for {
          session <- S.session ?~ "sesson not found"
        }yield JString(session.uniqueId)
      }
      case "insert" :: "users" ::Nil Get _ => {
        createUser("howard0010@yahoo.com","52012345","howard","lin")
        createUser("howard0020@yahoo.com","52012345","Troy","Huang")
        createUser("howard0030@yahoo.com","52012345","Stefan","Wing")
        createUser("howard0040@yahoo.com","52012345","Richard","Gee")
        createUser("howard0050@yahoo.com","52012345","Bbk","Tseng")
        createUser("howard0060@yahoo.com","52012345","Andrew","Ally")
        createUser("howard0070@yahoo.com","52012345","Gozu","Luo")
        createUser("howard0080@yahoo.com","52012345","Vincent","Kiang")
        createUser("howard0090@yahoo.com","52012345","Mohit","Verma")
        createUser("howard00100@yahoo.com","52012345","Andy","Mark")
        createUser("howard00110@yahoo.com","52012345","Linhu","Chen")
        createUser("howard00120@yahoo.com","52012345","Lincoln","Pahwa")
        createUser("howard00130@yahoo.com","52012345","Xiao Qiang","Wu")
        createUser("howard00140@yahoo.com","52012345","Sheng","Jun")
        toJSONList()
      }
      case "serve" :: "image" :: Nil Get _ => {
        var resource = LiftRules.getResource("/images/searchNearMe.jpg")
        JString(resource.toString())
        //resource.toStream
      }
    })
  def createUser(email:String, password:String, firstName:String, lastName:String):UserModel = {
    var user = UserModel.findOrCreate(By(UserModel.email,email))
      .email(email).password(password).firstName(firstName).lastName(lastName)
    user.saveMe
  }
}
