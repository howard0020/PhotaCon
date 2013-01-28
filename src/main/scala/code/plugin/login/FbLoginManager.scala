package code.plugin.login

import code.plugin.LoginManager
import org.scribe._
import oauth._
import builder._
import api.FacebookApi
import code.model._
import code.plugin.Plugins
import code.util.SiteConsts
import net.liftweb.http.S
import net.liftweb.json._
import net.liftweb.json.JsonParser
import net.liftweb.json.Printer._
import net.liftweb.json.JsonAST._
import net.liftweb.json.Extraction._
import model._
import net.liftweb.common._

class FbLoginManager extends LoginManager {
	val plugin = Plugins.facebook
	val secret = SiteConsts.readProp("secret."+plugin.toString())
	val appKey = SiteConsts.readProp("appkey."+plugin.toString())
	val callBack = SiteConsts.SITE_DOMAIN + callBackDir + plugin.toString()
	
	
	var service = init
	
	def init: OAuthService= {
		    new ServiceBuilder()
		.provider(classOf[FacebookApi])
		.apiKey(appKey)
		.apiSecret(secret)
		.callback(callBack)
		.build()
	}
	
	def getAuthUrl(): String = {
	  service.getAuthorizationUrl(null)
	}
	
	def getAccessToken: String = {
	  S.param("code") match {
	    case Full(token) => {
	        var v = new Verifier(token);
	        var accessToken = service.getAccessToken(null, v)
	        accessToken.getToken
	    }
	  }
	}
  def testToken(accessToken: Token) = {
    var request = new OAuthRequest(Verb.GET, "https://graph.facebook.com/me");
    service.signRequest(accessToken, request);
    var response = request.send();
    Console.println(response.getCode)
    Console.println(response.getBody)
  }
  
  def verifyToken(token:String):Boolean = {
    var request = new OAuthRequest(Verb.GET, "https://graph.facebook.com/me");
    service.signRequest(token, request);
    var response = request.send
    if (response.getCode == 200) return true
    else return false
  }
  def isConnected(currAccount:AccountModel,account: AccountModel):Box[Boolean] = {
    var request = new OAuthRequest(Verb.GET, 
        "https://graph.facebook.com/%s/friends/%s".format(currAccount.pluginId.get,account.pluginId.get))
    Console.println(request.toString())
    service.signRequest(currAccount.accessToken.get,request)
    var response = request.send
    if (response.getCode == 200){
      val json = JsonParser.parse(response.getBody)
      val id = json \ "data" \ "id"
      if (id == JsonAST.JNothing){
        Full(false)
      }else{
        Full(true)
      }
    }else{
      Empty
    }
  }
  def initAccount(account: AccountModel):Boolean = {
    try{
	    var request = new OAuthRequest(Verb.GET, "https://graph.facebook.com/me");
	    service.signRequest(account.accessToken.get, request);
	    var response = request.send
	    Console.println(response.getCode)
	    Console.println(response.getBody)
	    if (response.getCode == 200){

	      var json = JsonParser.parse(response.getBody)
	      var id = (json \ "id").extract[String]
	      var firstName = (json \ "first_name").extract[String]
	      var lastName = (json \ "last_name").extract[String]
	      account.pluginId(id)
	      val user = account.user.obj.openOrThrowException("missing user for account")
	      user.firstName(firstName).lastName(lastName)
	      account.save
	      user.save
	    }else{
	      return false
	    }
	    return true
    }catch{
      case ex:Exception => {
        return false
      }
    }
  }
}