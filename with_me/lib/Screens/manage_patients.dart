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
      // appBar: StyledAppBar(
      //   context,
      //   "איתי",
      //   actions: [
      //     GestureDetector(
      //       child: const Icon(Icons.logout),
      //       onTap: () {
      //         context.read<FirebaseAuthMethods>().signOut(context);
      //       },
      //     ),
      //   ],
      // ),

      body: CircularAppBar("רשימת מטופלים", [

        StreamBuilder<QuerySnapshot>(
          stream: DB.getPatients(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var volunteers = {};
              int index = 0;

              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map<String, dynamic>;
                print(data);
                volunteers[index] = Patient.fromMap(data, doc.id);
                index++;
              }

              if (volunteers.isEmpty) {
                return const Center(child: Text("אין מתנדבים להצגה"));
              }
              return _volunteersList(volunteers)!;
            }
            return const Center(child: CircularProgressIndicator());
          }),], context)
    );
  }

  Widget? _volunteersList(var volunteers) {
    return ListView.builder(
      itemCount: volunteers.length+1,
      itemBuilder: (context, index) => index==0? Container(height: 150,):_volunteerCard(volunteers[index-1])!,
    );
  }

  Widget? _volunteerCard(Patient volunteer) {
    TextEditingController textControllerplace = TextEditingController();
    TextEditingController textControllertime = TextEditingController();
    TextEditingController textControllerStation = TextEditingController();
    double pad=8;
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
                Padding(padding: EdgeInsets.all(pad), child: Input(textControllerStation, 'תחנה הבאה')),
                Padding(padding: EdgeInsets.all(pad), child: Input(textControllertime, 'זמן')),
                Padding(padding: EdgeInsets.all(pad), child:Input(textControllerplace, 'מיקום התחנה'))
              ]),
              Button((){
                if (volunteer.dayTasks==null) volunteer.dayTasks=[];
                volunteer.dayTasks!.add(
                    Station(textControllerStation.text==""?null:textControllerStation.text,
                        textControllerplace.text==""?null:textControllerplace.text,
                        textControllertime.text==""?null:textControllertime.text));
                DB.insertPatient(volunteer);},'עדכן\n מטופל')
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
