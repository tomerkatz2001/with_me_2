
import '../header.dart';

class LoginSignupPage extends StatefulWidget {
  final loginSignupFlag;
  const LoginSignupPage(this.loginSignupFlag,{Key? key}) : super(key: key);

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _validFields = List.filled(3, true);

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String emptyFieldMessage = "please fill in this field";

  @override
  Widget build(BuildContext context) {
    bool checknullSignup() {
      setState(() {
        _validFields = List.filled(3, true);
      });
      if (!widget.loginSignupFlag && userController.text.isEmpty)
        setState(() {
          _validFields[0] = false;
        });

      if (emailController.text.isEmpty)
        setState(() {
          _validFields[1] = false;
        });
      if (passwordController.text.isEmpty) {
        setState(() {
          _validFields[2] = false;
        });
      }
      if (_validFields.any((e) => !e)) {
        print("field is false");
        return false;
      }
      return true;
    }

    bool checknullLogin() {
      setState(() {
        _validFields = List.filled(3, true);
      });
      if (emailController.text.isEmpty)
        setState(() {
          _validFields[0] = false;
        });
      if (passwordController.text.isEmpty) {
        setState(() {
          _validFields[1] = false;
        });
      }
      if (_validFields.any((e) => !e)) {
        print("field is false");
        return false;
      }
      return true;
    }

    void loginUser() {
      if (!checknullLogin()) return;
      context.read<FirebaseAuthMethods>().loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }

    void signUpUser() async {
      if (!checknullSignup()) return;
      print("owner is signing up");
      context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
          name: userController.text);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: <Widget>[
              Align(alignment: Alignment.center,child:Text(widget.loginSignupFlag ? "Log in to OptiGym" : "Sign up to OptiGym",
              )),
              const SizedBox(height: 5),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Continue with Email"),
                  ],
                ),
              ),
              widget.loginSignupFlag
                  ? const SizedBox()
                  : Input(userController, "Gym/User Name",
                  validFlag:
                  widget.loginSignupFlag ? null : _validFields[0],
                  errorText: emptyFieldMessage),
              Input(emailController, "Email",
                  validFlag: widget.loginSignupFlag
                      ? _validFields[0]
                      : _validFields[1],
                  errorText: emptyFieldMessage),
              Input(passwordController, "Password",
                  hideFlag: true,
                  validFlag: widget.loginSignupFlag
                      ? _validFields[1]
                      : _validFields[2],
                  errorText: emptyFieldMessage),
              const SizedBox(height: 5),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.loginSignupFlag ?
                        MaterialButton( onPressed:loginUser, child: Text("Log in"))
                            :
                        MaterialButton( onPressed:signUpUser, child: Text("Sign Up"))
                      ]
                  )
              ),
              Center(
                  child: widget.loginSignupFlag ? TappableText("Don't have a user? sign up here", (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/signup');
                  }): const SizedBox()
              )
            ],
          )
      ),
    );
  }
}