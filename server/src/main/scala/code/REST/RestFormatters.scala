package code.REST

import code.model._
import net.liftweb.json.JsonDSL._
import net.liftweb.json.JsonAST._
import java.text.SimpleDateFormat

object RestFormatters {

  // A simple helper to generate the REST ID of an user
  def restId(user: UserModel) =
    "photacon" + user.id

  def toJSON(user: UserModel): JObject = {
    ("user" ->
      ("id" -> restId(user)) ~
      ("email" -> user.email.is) ~
      ("firstName" -> user.firstName.is) ~
      ("lastName" -> user.lastName.is) ~
      ("accounts" -> user.accounts.map(account=>toJSON(account))))
  }
  def toJSON(account: AccountModel): JObject = {
	  ("plugin" -> account.plugin.is.toString()) ~
	  ("email" -> account.email.is) ~
	  ("pluginId" -> account.pluginId.is)
  }
//  def toJSON(currAccount: AccountModel, otherAccount:AccountModel): JValue = {
//    var currJson = toJSON(currAccount)
//     ("sd" -> "sd") ~ currJson
//  }
  def toJSONList(users:List[UserModel]): JArray = {
    JArray(users.map(user => toJSON(user)))
  }
}