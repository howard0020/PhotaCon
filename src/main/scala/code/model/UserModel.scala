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

object UserModel extends UserModel with MetaMegaProtoUser[UserModel]{

}
class UserModel extends MegaProtoUser[UserModel]
