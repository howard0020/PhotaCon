package bootstrap.liftweb

import net.liftweb._
import util._
import Helpers._
import common._
import http._
import sitemap._
import Loc._
import net.liftmodules.JQueryModule
import net.liftweb.http.js.jquery._
import code.REST._
import code.util._
import mapper._
import code.model._
/**
 * A class that's instantiated early and run.  It allows the application
 * to modify lift's environment
 */
class Boot {
  def boot {
    //init props
    SiteConsts.init
    // setup database configuration
    initDB
    // where to search snippet
    LiftRules.addToPackages("code")

    // Build SiteMap
    val entries = List(
      Menu.i("Index") / "index", // the simple way to declare a menu
      Menu.i("Login") / "login",
      Menu.i("Search") / "search",
      Menu.i("Home") / "home",
      Menu.i("PersonDetail") / "personDetail",
      Menu.i("AppLogin") / "appLogin",
      Menu.i("Friend") / "friend",
      Menu.i("Setting") / "setting",
      Menu.i("Facebook") / "facebookLogin",
      Menu.i("SearchNearMe") / "searchNearMe",
      // more complex because this menu allows anything in the
      // /static path to be visible
      Menu(Loc("Static", Link(List("static"), true, "/static/index"), 
	       "Static Content")))

    // set the sitemap.  Note if you don't want access control for
    // each page, just comment this line out.
    LiftRules.setSiteMap(SiteMap(entries:_*))
    
    //standerd lift configuration
    initStdConfig
    
    //add REST Web Services
    LiftRules.dispatch.append(HomeContentService).append(LoginService).append(TestService).append(SearchService)
    
    //initScribe
  }
  def initDB {
    if (!DB.jndiJdbcConnAvailable_?) {
      val vendor = new StandardDBVendor(
        SiteConsts.DB_DRIVER, SiteConsts.getDBUrl,
        Full(SiteConsts.DB_USER), Full(SiteConsts.DB_PASSWORD))

      LiftRules.unloadHooks.append(vendor.closeAllConnections_! _)

      DB.defineConnectionManager(DefaultConnectionIdentifier, vendor)
    }

    // Use Lift's Mapper ORM to populate the database
    // you don't need to use Mapper to use Lift... use
    // any ORM you want
    Schemifier.schemify(true, Schemifier.infoF _, UserModel, AccountModel) 
  }
  def initStdConfig{
    //============= STANDARD LIFT PROJECT CODE =================== //
    //Show the spinny image when an Ajax call starts
    LiftRules.ajaxStart =
      Full(() => LiftRules.jsArtifacts.show("ajax-loader").cmd)
    
    // Make the spinny image go away when it ends
    LiftRules.ajaxEnd =
      Full(() => LiftRules.jsArtifacts.hide("ajax-loader").cmd)

    // Force the request to be UTF-8
    LiftRules.early.append(_.setCharacterEncoding("UTF-8"))

    // Use HTML5 for rendering
    LiftRules.htmlProperties.default.set((r: Req) =>
      new Html5Properties(r.userAgent))

    //Init the jQuery module, see http://liftweb.net/jquery for more information.
    LiftRules.jsArtifacts = JQueryArtifacts
    JQueryModule.InitParam.JQuery=JQueryModule.JQuery172
    JQueryModule.init()
  }
}
