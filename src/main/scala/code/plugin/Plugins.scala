package code.plugin

object Plugins extends Enumeration{
	type Plugins = Value
	
	val facebook = Value("facebook")
	val linkedin = Value("linkedin")
	val twitter = Value("twitter")
	
	implicit def PluginsValue2String(plugin: Plugins.Value):String = {
	  plugin.toString
	} 
}