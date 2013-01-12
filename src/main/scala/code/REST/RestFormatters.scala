package code.REST
import code.model.UserModel
import net.liftweb.json.JsonDSL._
import net.liftweb.json.JsonAST._
import java.text.SimpleDateFormat

object RestFormatters {
  /* The REST timestamp format. Not threadsafe, so we create
   * a new one each time. */
  def timestamp = new SimpleDateFormat("yyyy-MM-dd¡¯T¡¯HH:mm:ss¡¯Z¡¯")
  
  // A simple helper to generate the REST ID of an user
  def restId (user: UserModel) =
    "photacon" + user.id
    

  def toJSON(user: UserModel): JValue = {
    ("user" ->
		("id" -> restId(user)) ~
		("email" -> user.email.is)
    )
  }
}