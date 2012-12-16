package code.plugin.login

import code.plugin.LoginManager
import org.scribe._
import oauth._
import builder._
import api.FacebookApi
import model.Verifier
import org.scribe.model.Token
import code.plugin.Plugins
import code.util.SiteConsts
import net.liftweb.common.Full
import net.liftweb.http.S


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
}