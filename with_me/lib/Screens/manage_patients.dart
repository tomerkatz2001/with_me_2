import 'package:with_me/Objects/patient.dart';

import '../header.dart';

class ManageVolunteers extends StatefulWidget {
  const ManageVolunteers({Key? key}) : super(key: key);

  @override
  State<ManageVolunteers> createState() => _ManageVolunteersState();
}

class _ManageVolunteersState extends State<ManageVolunteers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        context,
        "איתי",
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: DB.getPatients(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var volunteers = {};
              int index = 0;

              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map<String, dynamic>;
                volunteers[index] = Patient.fromMap(data, doc.id);
                index++;
              }

              if (volunteers.isEmpty) {
                return const Center(child: Text("אין מתנדבים להצגה"));
              }
              return _volunteersList(volunteers)!;
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget? _volunteersList(var volunteers) {
    return ListView.builder(
      itemCount: volunteers.length,
      itemBuilder: (context, index) => _volunteerCard(volunteers[index])!,
    );
  }

  Widget? _volunteerCard(Patient volunteer) {
    TextEditingController textControllerplace = TextEditingController();
    TextEditingController textControllertime = TextEditingController();

    return Card(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ExpansionTile(
        title: Text(volunteer.name),
        subtitle: Text(volunteer.email),
        children: <Widget>[
          Row(
            children: [
              Column(children: [
                Input(textControllerplace, 'תחנה הבאה'),
                Input(textControllertime, 'זמן'),
              ]),
              Button((){
                if (volunteer.dayTasks==null) volunteer.dayTasks=[];
                volunteer.dayTasks!.add(textControllerplace.text+textControllertime.text);
                DB.insertPatient(volunteer);},'שלח')
            ],
          )
        ],
      ),
      // ListTile(
      //   title: Text(volunteer.name),
      //   subtitle: Text(volunteer.email),
      //   onTap: () {
      //     Navigator.of(context).pushNamed('/volunteer_page',
      //         arguments: VolunteerPageArguments(volunteer));
      //   },
      // ),
    );
  }
}
