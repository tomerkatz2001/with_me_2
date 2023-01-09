import 'package:happy_heart/header.dart';


class Permissions{
  static int _user=-1;
  static const int manager=2;
  static const int caller=1;
  static const int volunteer=0;

  static Future<int> getFirstUserPermissions(BuildContext context) async{
    if(_user>=0){return _user;}
    String uid= context.read<FirebaseAuthMethods>().user.uid;
    _user = await DB.getPermissions(uid);
    if(_user<-1){
      context.read<FirebaseAuthMethods>().signOut(context);
      // displaySnackbar("אתה מחובר לשרת הלא נכון, אנא צור משתמש חדש בשרת הזה", context);
    }
    return _user;
  }

  static int getUserPermissions(){
    return _user;
  }

}