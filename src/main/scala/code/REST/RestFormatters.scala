package code.REST

import code.model._
import net.liftweb.json.JsonDSL._
import net.liftweb.json.JsonAST._
import java.text.SimpleDateFormat

object RestFormatters {

  // A simple helper to generate the REST ID of an user
  def restId(user: UserModel) =
    "photacon" + user.id

  def toJSON(user: UserModel): JValue = {
    ("user" ->
      ("id" -> restId(user)) ~
      ("email" -> user.email.is) ~
      ("firstName" -> user.firstName.is) ~
      ("lastName" -> user.lastName.is) ~
      ("accounts" -> user.accounts.map(account=>toJSON(account))))
  }
  def toJSON(account: AccountModel): JValue = {
	  ("plugin" -> account.plugin.is.toString()) ~
	  ("email" -> account.email.is) ~
	  ("pluginId" -> account.pluginId.is)
  }
  def toJSONList(): JValue = {
    UserModel.findAll().map(user => toJSON(user))
  }
}