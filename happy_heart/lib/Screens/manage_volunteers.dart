import 'package:happy_heart/Objects/volunteer.dart';

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
        "לב חדווה",
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout, color: Colors.white),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: DB.getUsersByPermissions(Permissions.volunteer),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var volunteers = {};
              int index = 0;

              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map;
                volunteers[index] = Volunteer(data["name"],
                    "${data["name"]}@gmail.com"); // TODO: add email: data["email"]
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

  Widget? _volunteerCard(Volunteer volunteer) {
    return Card(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(volunteer.name),
        subtitle: Text(volunteer.email),
        onTap: () {
          Navigator.of(context).pushNamed('/volunteer_page',
              arguments: VolunteerPageArguments(volunteer));
        },
      ),
    );
  }
}
