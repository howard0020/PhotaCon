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
import code.plugin.Plugins

class UserModel extends MegaProtoUser[UserModel] with OneToMany[Long,UserModel]{
  def getSingleton = UserModel
  object accounts extends MappedOneToMany(AccountModel,AccountModel.user,OrderBy(AccountModel.id,Ascending))

  def findAccount(plugin: Plugins.Value) = {
    AccountModel.find(By(AccountModel.user,id),By(AccountModel.plugin,plugin))
  }
}
object UserModel extends UserModel with MetaMegaProtoUser[UserModel]{
  override def dbTableName = "users"
  // comment this line out to require email validations
  override def skipEmailValidation = true
  
  def findUserByEmail(email: String) = find(By(UserModel.email, email))
  
  def createByEmail(email: String):Box[UserModel] = {
    if (findUserByEmail(email).isEmpty){
      Full(create)
    }else Failure("User Exist")
  }
  
  def findUserByName(name: String):List[UserModel] = {
    var sqlQuery = "select * from users order by least(fn_levenshtein('%s',concat_ws(' ',firstName,lastName)),fn_levenshtein('%s',concat_ws(' ',lastName,firstName))) limit 20"
    sqlQuery = sqlQuery format(name,name)
    findAllByInsecureSql(sqlQuery,IHaveValidatedThisSQL("howard","2013-01-27"))
  }
}

