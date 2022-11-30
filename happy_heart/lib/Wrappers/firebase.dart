import '../header.dart';

class FirebaseWrapper extends StatelessWidget {

  final Future<FirebaseApp> _initialization=Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final List<SingleChildWidget> firebaseProviders =
  [ Provider<FirebaseAuthMethods>(create: (_)
  => FirebaseAuthMethods(FirebaseAuth.instance)),
    StreamProvider(
      create: (context) => context.read<FirebaseAuthMethods>().authState,
      initialData: null,
    )];

  FirebaseWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
              home: Scaffold(
                  body: Center(
                      child: Text(snapshot.error.toString(),
                          textDirection: TextDirection.ltr)
                  )
              )
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: firebaseProviders,
            child: Application(),
          );
        }
        //TODO: Animations
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}