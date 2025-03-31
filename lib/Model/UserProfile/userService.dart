import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/enum/RolesEnum.dart';

class UserService 
{
  final UserProfile userProfile = UserProfile();

  Future<Map<String,dynamic>?> getUserCredentials()
  {
    return userProfile.createAndgetUserData("userDetails");      
  }

  Future<bool> checkRole() async
  {
    Map<String,dynamic>? userData = await getUserCredentials();
    if(userData != null)
    {      
      Rolesenum userRole = Rolesenum.values.firstWhere(
      (e) => e.toString() == userData["roles"]
      );
      return userRole.index >= Rolesenum.Manager.index;
    }
    else
    {
      return false;
    }
  }
}