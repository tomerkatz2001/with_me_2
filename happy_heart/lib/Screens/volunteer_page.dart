import '../header.dart';

class VolunteerPageArguments {
  final Volunteer volunteer;
  VolunteerPageArguments(this.volunteer);
}

class VolunteerPage extends StatefulWidget {

  const VolunteerPage({Key? key}) : super(key: key);


  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as VolunteerPageArguments;
    Volunteer volunteer = arguments.volunteer;

    final Map volunteerData = volunteer.getVolunteerData();

    return Scaffold(
      appBar: StyledAppBar(
          context, volunteer.name, leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back))),
        body: ListView.builder(
          itemCount: volunteerData.length,
          itemBuilder: (context, index){
            return Card(
              shadowColor: Colors.black,
              child: ListTile(
                title: Text("${volunteerData.keys.elementAt(index)}: ${volunteerData.values.elementAt(index)}"),
              ),
            );
        },)
    );
  }
}
