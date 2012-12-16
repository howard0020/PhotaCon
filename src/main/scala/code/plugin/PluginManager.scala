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
}