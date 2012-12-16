package code.util
import net.liftweb.util.Props
import net.liftweb.common.Full
import net.liftweb.common.Empty

object SiteConsts {
  // DB consants
//  val DB_DRIVER = readProp("db.driver")
//  val DB_URL = readProp("db.url")
//  val DB_DBNAME = Option(System.getProperty("RDS_DB_NAME")).getOrElse(readProp("db.dbname"))
//  val DB_PORT = Option(System.getProperty("RDS_PORT")).getOrElse(readProp("db.port"))
//  val DB_HOSTNAME = Option(System.getProperty("RDS_HOSTNAME")).getOrElse(readProp("db.hostname"))
//  val DB_USER = Option(System.getProperty("RDS_USERNAME")).getOrElse(readProp("db.user"))
//  val DB_PASSWORD = Option(System.getProperty("RDS_PASSWORD")).getOrElse(readProp("db.password"))
//  
  //login props
  val SITE_DOMAIN = readProp("site.domain")

  
  def readProp(key: String, defaultValue:Option[String]=None): String = {
    val errorMsg = "SiteConsts.init: " + key + " is missing in properties file"
    Props.get(key) match { 
      case Full(value) => value
      case Empty => defaultValue match {
        case Some(value) => value
        case None => throw new RuntimeException(errorMsg)
      }
      case _ => throw new RuntimeException(errorMsg)
    }
  }
//  def getDBUrl = {
//    var url = ""
//    try{
//      url = "jdbc:mysql://" + DB_HOSTNAME +  ":" + DB_PORT + "/" +DB_DBNAME
//    }catch{
//      case e:Exception => url = DB_URL
//    }
//    url
//  }
  def init {
  }
}