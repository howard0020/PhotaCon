package code.plugin.login

import code.plugin.LoginManager
import org.scribe._
import oauth._
import builder._
import api.TwitterApi
import model.Verifier
import org.scribe.model.Token
import code.plugin.Plugins
import code.util.SiteConsts
import net.liftweb.http.S
import net.liftweb.common.Full

class TwitterLoginManager extends LoginManager {
	val plugin = Plugins.twitter
	val secret = SiteConsts.readProp("secret."+plugin.toString())
	val appKey = SiteConsts.readProp("appkey."+plugin.toString())
	val callBack = SiteConsts.SITE_DOMAIN + callBackDir + plugin.toString()
	var reqToken:Token = null
	var service = init
	
	def init: OAuthService= {
		    new ServiceBuilder()
		.provider(classOf[TwitterApi])
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
}