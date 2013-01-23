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
  implicit def str2Token(str: String):Token = {
    return new Token(str,secret)
  }
}