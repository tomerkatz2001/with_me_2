import 'package:happy_heart/Screens/add_equipment.dart';
import 'package:happy_heart/Screens/equipment_type.dart';

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
      initialRoute: '/' ,
      routes: {
        '/': (context) => const LoginWrapper(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginSignupPage(true),
        '/signup': (context) => const LoginSignupPage(false),
        '/add_equipment': (context) => const AddEquipmentPage(),
        '/equipment_type': (context) => const EquipmentTypePage(),
        '/manage_volunteers': (context) => const ManageVolunteers(),
        '/volunteer_page': (context) => const VolunteerPage(),
      },
    );
  }
}
