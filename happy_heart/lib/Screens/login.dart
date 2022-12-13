
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
      await context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
          name: userController.text);
      DB.insertUser(context.read<FirebaseAuthMethods>().user.uid, userController.text);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StyledAppBar(context, "התחברות", leading:  !widget.loginSignupFlag?
        GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            }
        ):Container(),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Align(alignment: Alignment.center,child:Text(widget.loginSignupFlag ? "התחברות ללב חדוֿה" : "הרשמה ללב חדוה")),
              VerticalSpacer(5),
              Center(child:Image.asset('assets/lev-hedva.png')),
              VerticalSpacer(5),
              widget.loginSignupFlag
                  ? const SizedBox()
                  : Input(userController, "שם",
                  validFlag:
                  widget.loginSignupFlag ? null : _validFields[0],
                  errorText: emptyFieldMessage),
              Input(emailController, "כתובת אימייל",
                  validFlag: widget.loginSignupFlag
                      ? _validFields[0]
                      : _validFields[1],
                  rtl: false,
                  errorText: emptyFieldMessage),
              VerticalSpacer(20),
              Input(passwordController, "סיסמא",
                  hideFlag: true,
                  validFlag: widget.loginSignupFlag
                      ? _validFields[1]
                      : _validFields[2],
                  rtl: false,
                  errorText: emptyFieldMessage),
              VerticalSpacer(20),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.loginSignupFlag ?
                        Button( loginUser, "התחברות")
                            :
                        Button( signUpUser, "הרשמה")
                      ]
                  )
              ),
              VerticalSpacer(10),
              Center(
                  child: widget.loginSignupFlag ? TappableText("אין לך משתמש? לחץ כאן על מנת להרשם", (){
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