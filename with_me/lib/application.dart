import 'package:flutter/services.dart';
import 'package:with_me/Screens/add_equipment.dart';
import 'package:with_me/Screens/add_type.dart';
import 'package:with_me/Screens/equipment_type.dart';
import 'package:with_me/Screens/visit_course.dart';


import 'Screens/search.dart';
import 'header.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Happy Heart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        fontFamily: 'RaleWay',
        useMaterial3: true,
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 26.0,fontWeight: FontWeight.w800),
          ),
        ),
      initialRoute: '/' ,
      routes: {
        '/': (context) => const LoginWrapper(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginSignupPage(true),
        '/signup': (context) => const LoginSignupPage(false),
        '/add_equipment': (context) => const AddEquipmentPage(),
        '/add_type': (context) => const AddTypePage(),
        '/equipment_type': (context) => const EquipmentTypePage(),
        '/manage_volunteers': (context) => const ManageVolunteers(),
        '/volunteer_page': (context) => const VolunteerPage(),
        '/search_page' : (context) => const SearchPage(),
        '/verify_user': (context) => const VerifyUsersPage(),
        '/my_visit': (context) => const VisitCoursePage(),
        '/make_weekly_tasks': (context)=> MakeTaskPage()
      },
    );
  }
}
