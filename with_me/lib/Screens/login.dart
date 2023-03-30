
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
      // DB.insertUser(context.read<FirebaseAuthMethods>().user.uid, userController.text);
      DB.insertUser(Client(userController.text,
        context.read<FirebaseAuthMethods>().user.uid,
        emailController.text,
        -1
      )
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: CircularAppBar(
          widget.loginSignupFlag ? "": "הרשמה",
          [Container(child:
            Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(height: 120,),
                  widget.loginSignupFlag ? SizedBox(height: 125, width: 125, child:FittedBox(fit: BoxFit.fill,child: Image.asset('assets/logo.png'))):Container(),
                  VerticalSpacer(5),
                  Align(alignment: Alignment.center,child:Text(style: GoogleFonts.assistant(
                      fontSize: widget.loginSignupFlag?26:16, fontWeight: FontWeight.w700), widget.loginSignupFlag ? "איתי, חוויה חדשה למטופלים" : "ברוכים הבאים. אנא מלאו את הפרטים הבאים")),
                  VerticalSpacer(5),
                  widget.loginSignupFlag? Container(height: 100,) : Container(),
                  widget.loginSignupFlag
                      ? const SizedBox()
                      : Input(userController, "שם",
                      validFlag:
                      widget.loginSignupFlag ? null : _validFields[0],
                      errorText: emptyFieldMessage),
                  widget.loginSignupFlag ? Container() : VerticalSpacer(20),
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
                      }): TappableText("כבר רשום? לחץ כאן על מנת להתחבר", (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      }),
                  ),
                  widget.loginSignupFlag ? Container(): SizedBox(height: 220, child: FittedBox(child:Image.asset('assets/trampoline.png'),fit: BoxFit.fitWidth)),
                ],
              ),
            )
        ),
    ),],
        context,
        back_arrow: Container(),
        offset: widget.loginSignupFlag ? -200:0,
        color: widget.loginSignupFlag ?Color(0x42cfc780):Color(0xffCBC3E3),
      ),
    );
  }
}