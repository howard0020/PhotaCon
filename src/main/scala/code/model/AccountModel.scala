package code.model

import net.liftweb.mapper._
import code.plugin.Plugins
/**
 * Created with IntelliJ IDEA.
 * User: chenghaolin
 * Date: 1/13/13
 * Time: 11:32 PM
 * Project: PhotaCon
 * To change this template use File | Settings | File Templates.
 */
class AccountModel extends LongKeyedMapper[AccountModel]{
  def getSingleton = AccountModel
  def primaryKeyField = id
  object id extends MappedLongIndex(this)

  object plugin extends MappedEnum(this,Plugins)
  object email extends MappedString(this,64)
  object accessToken extends MappedText(this)
  object user extends MappedLongForeignKey(this,UserModel)

}
object AccountModel extends AccountModel with LongKeyedMetaMapper[AccountModel]{
	def findAccountByEmailPlugin(email: String, plugin: Plugins.Value) = find(By(AccountModel.email, email),By(AccountModel.plugin,plugin))
}
