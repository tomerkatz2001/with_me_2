import '../header.dart';


class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  User get user => _auth.currentUser!;
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).popUntil((route) => route == '/');
      Navigator.pushNamed(context,'/');
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        displaySnackbar('The password provided is too weak.',context);
        print("weak pass");
      } else if (e.code == 'email-already-in-use') {
        displaySnackbar('The account already exists for that email.',context);
        print('already used');
      }
      displaySnackbar(e.message!,context); // Displaying the usual firebase error message
    }
    

  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Login failed");
    }
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }


  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
    }
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
    }
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}