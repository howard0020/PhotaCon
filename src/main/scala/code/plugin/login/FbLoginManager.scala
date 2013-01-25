package code.plugin.login

import code.plugin.LoginManager
import org.scribe._
import oauth._
import builder._
import api.FacebookApi
import model._
import code.plugin.Plugins
import code.util.SiteConsts
import net.liftweb.common.Full
import net.liftweb.http.S
import net.liftweb.common.Full
import code.model.AccountModel
import net.liftweb.json.JsonParser

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
    Console.println(response.getCode)
    Console.println(response.getBody)
    var jsonBox = JsonParser.parse(response.getBody())
    
    return true;
  }
  def isConnected(id: String,account: AccountModel):Boolean = {
    var request = new OAuthRequest(Verb.GET, 
        "https://graph.facebook.com/%s/friends/%s".format(account.pluginId.is,id))
    Console.println(request.toString())
    service.signRequest(account.accessToken.is,request)
    var response = request.send
    Console.println(response.getCode)
    Console.println(response.getBody)
    return true;
  }
}