import 'package:happy_heart/Objects/volunteer.dart';

import '../header.dart';

class ManageVolunteers extends StatefulWidget {
  const ManageVolunteers({Key? key}) : super(key: key);

  @override
  State<ManageVolunteers> createState() => _ManageVolunteersState();
}

// TODO: get from firebase
List<Volunteer> volunteers = [Volunteer("Matan Beigel", "m@gmail.com"), Volunteer("Alon", "a@gmail.com"), Volunteer("Ido", "i@gmqil.com")];

class _ManageVolunteersState extends State<ManageVolunteers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
            context, "רשימת מתנדבים", leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back))),
        body: ListView.builder(
        itemCount: volunteers.length,
        itemBuilder: (context, index){
          return Card(
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(volunteers[index].name),
              subtitle: Text(volunteers[index].email),
              onTap: () {
                Navigator.of(context).pushNamed('/volunteer_page', arguments: VolunteerPageArguments(volunteers[index]));
              },
            ),
          );
        },)
    ,
    );
  }
}
