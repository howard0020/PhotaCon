package code.plugin
import org.scribe.model.Token
import org.scribe.model.OAuthRequest
import org.scribe.model.Verb
import code.model.AccountModel

trait LoginManager {
	val plugin: Plugins.Value
	val secret: String
	val appKey: String
	val callBackDir = "/api/login/success/accessToken/"
	val callBack: String
	
	def getAuthUrl(): String
	def getAccessToken(): String
	def verifyToken(token:String):Boolean
	def isConnected(id: String,account: AccountModel):Boolean
	
	  implicit def str2Token(str: String):Token = {
    return new Token(str,secret)
  }
}