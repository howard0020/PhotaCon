package code.plugin

import login._
import Plugins._


object PluginManager {
	var FBLoginManager = new FbLoginManager
	var TwitterLoginManager = new TwitterLoginManager
	var LinkedinLoginManager = new LinkedinLoginManager
	def getLoginManager(name: String):LoginManager = {
		name match {
	    case "twitter" => TwitterLoginManager
	    case "facebook" => FBLoginManager
	    case "linkedin" => LinkedinLoginManager
	  }
	}
	def getLoginManager(name:Plugins.Value):LoginManager = {
	  getLoginManager(name.toString)
	}
	def verifyToken(token: String,name: String) = {
	  var manager = getLoginManager(name)
	  manager.verifyToken(token)
	}
}