import 'header.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Heart',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'RaleWay',
      ),
      home: const LoginWrapper(),
      routes:  {
        '/home' : (context) => const HomePage(),
        '/login': (context) => const LoginSignupPage(true),
        '/signup': (context) => const LoginSignupPage(false),
      }
      ,
    );
  }
}
