package code.plugin

import login._
import Plugins._
import code.model._
import net.liftweb.common._
import Box._
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
	def verifyToken(token: String,name: String) = {
	  var manager = getLoginManager(name)
	  manager.verifyToken(token)
	}
	
	def initAccount(account: AccountModel,plugin:Plugins.Value) = {
	  var manager = getLoginManager(plugin)
	  manager.initAccount(account)
	}

  def isConnected(currAccount:AccountModel,account:AccountModel):Box[Boolean] = {
    if (currAccount == null || account == null) {
      Empty
    }else if (currAccount.plugin.get != account.plugin.get) {
      Empty
    }else {
      val manager = getLoginManager(currAccount.plugin.get)
      manager.isConnected(currAccount,account)
    }
  }
}