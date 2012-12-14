package code.scribe

import org.scribe.oauth.OAuthService
import org.scribe.builder.ServiceBuilder
import org.scribe.builder.api.LinkedInApi
import org.scribe.builder.api.FacebookApi
import org.scribe.model.Verifier

object LoginServers {
	var authUrl = ""
	  
	def init = {
	   var service = new ServiceBuilder()
	.provider(classOf[FacebookApi])
	.apiKey("145499585599212")
	.apiSecret("95de9d782beee6c8b419fad72568cfdb")
	.callback("http://localhost:8080/")
	.build()
		
	authUrl = service.getAuthorizationUrl(null)
	
	Console.println(authUrl)
	var v = new Verifier("verifier you got from the user");
	var accessToken = service.getAccessToken(null,v);
	Console.println(accessToken)
	}
	
}