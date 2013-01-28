package code.plugin.login

import code.plugin.LoginManager
import org.scribe._
import oauth._
import builder._
import api.LinkedInApi
import model.Verifier
import org.scribe.model.Token
import code.plugin.Plugins
import code.util.SiteConsts
import net.liftweb.common.Full
import net.liftweb.http.S
import org.scribe.model.OAuthRequest
import org.scribe.model.Verb
import code.model.AccountModel
import net.liftweb.common._

class LinkedinLoginManager extends LoginManager {
	val plugin = Plugins.linkedin
	val secret = SiteConsts.readProp("secret."+plugin.toString())
	val appKey = SiteConsts.readProp("appkey."+plugin.toString())
	val callBack = SiteConsts.SITE_DOMAIN + callBackDir + plugin.toString()
	var reqToken:Token = null
	
	var service = init
	
	def init: OAuthService= {
		    new ServiceBuilder()
		.provider(classOf[LinkedInApi])
		.callback(callBack)
		.apiKey(appKey)
		.apiSecret(secret)
		.build()
	}
	
	def getAuthUrl(): String = {
	  reqToken = service.getRequestToken
	  service.getAuthorizationUrl(reqToken)
	}
	
	def getAccessToken: String = {
	  S.param("oauth_verifier") match {
	    case Full(token) => {
	        var v = new Verifier(token);
	        var accessToken = service.getAccessToken(reqToken, v)
	        accessToken.getToken
	    }
	  }
	}
def verifyToken(token:String):Boolean = {
    var request = new OAuthRequest(Verb.GET, "https://graph.facebook.com/me");
    service.signRequest(token, request);
    var response = request.send();
    Console.println(response.getCode)
    Console.println(response.getBody)
    return true
}
  def isConnected(currAccount:AccountModel,account: AccountModel):Box[Boolean] = {
    Full(false)
  }
	def initAccount(account:AccountModel):Boolean = {
	  return true
	}
}