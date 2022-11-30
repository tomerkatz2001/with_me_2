import '../header.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  getFirstPage(firebaseUser){
    if (firebaseUser == null) {
      print("user is not logged in");
      return const LoginSignupPage(true);
    }
    print("user is logged in");
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return getFirstPage(firebaseUser);
  }
}