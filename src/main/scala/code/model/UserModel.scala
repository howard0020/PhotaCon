package code.model

/**
 * Created with IntelliJ IDEA.
 * User: chenghaolin
 * Date: 1/12/13
 * Time: 12:14 PM
 * Project: PhotaCon
 * To change this template use File | Settings | File Templates.
 */
import net.liftweb.mapper._
import net.liftweb.util._
import net.liftweb.common._
import net.liftweb.common.Empty


object UserModel extends UserModel with MetaMegaProtoUser[UserModel]{
  override def dbTableName = "users"
  // comment this line out to require email validations
  override def skipEmailValidation = true
  
  def findUserByEmail(email: String) = UserModel.find(By(UserModel.email, email))
  
  def createByEmail(email: String):Box[UserModel] = {
    if (findUserByEmail(email).isEmpty){
      Full(create)
    }else Failure("User Exist")
  }
}
class UserModel extends MegaProtoUser[UserModel]{
  def getSingleton = UserModel
  
  
}
