package code.plugin

trait LoginManager {
	val plugin: Plugins.Value
	val secret: String
	val appKey: String
	val callBackDir = "/api/login/success/"
	val callBack: String
	
	def getAuthUrl(): String
	def getAccessToken(): String
}