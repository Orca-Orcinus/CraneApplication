import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/enum/RolesEnum.dart';

class UserService 
{
  final UserProfile userProfile = UserProfile();
  Rolesenum userRole = Rolesenum.None;

  Future<Map<String,dynamic>?> getUserCredentials()
  {
    return userProfile.createAndgetUserData("userDetails");      
  }

  bool get isAdmin => userRole == Rolesenum.Administrator;
  bool get isAccount => userRole == Rolesenum.Account;
  bool get isManager => userRole == Rolesenum.Manager;
  bool get isForemen => userRole == Rolesenum.Foremen;
  bool get isOperator => userRole == Rolesenum.Operator;

  Future<int> checkUserRole() async
  {
    Map<String,dynamic>? userData = await getUserCredentials();
    if(userData != null)
    {      
      userRole = Rolesenum.values.firstWhere(
      (e) => e.toString() == userData["roles"]
      );
      return userRole.index;
    }
    else
    {
      return 0;
    }
  }
}