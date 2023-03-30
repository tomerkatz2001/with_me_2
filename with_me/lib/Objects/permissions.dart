import 'package:with_me/header.dart';


class Permissions{
  static int _user=-1;
  static const int manager=2;
  static const int caller=1;
  static const int volunteer=0;

  static Future<int> getFirstUserPermissions(BuildContext context) async{
    String uid= context.read<FirebaseAuthMethods>().user.uid;
    _user = await DB.getPermissions(uid);
    return _user;
  }

  static int getUserPermissions(){
    return _user;
  }

}