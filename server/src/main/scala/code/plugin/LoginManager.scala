package code.plugin
import org.scribe.model.Token
import org.scribe.model.OAuthRequest
import org.scribe.model.Verb
import code.model.AccountModel
import net.liftweb.common._
trait LoginManager {
	val plugin: Plugins.Value
	val secret: String
	val appKey: String
	val callBackDir = "/api/login/success/accessToken/"
	val callBack: String
  implicit val formats = net.liftweb.json.DefaultFormats

	def getAuthUrl(): String
	def getAccessToken(): String
	def verifyToken(token:String):Boolean
	def isConnected(currAccount:AccountModel,account: AccountModel):Box[Boolean]
	def initAccount(account:AccountModel):Boolean
	  implicit def str2Token(str: String):Token = {
    return new Token(str,secret)
  }
}