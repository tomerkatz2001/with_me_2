import '../header.dart';

class VolunteerPageArguments {
  final Patient volunteer;
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
    Patient volunteer = arguments.volunteer;

    final Map volunteerData = volunteer.toMap();

    return Scaffold(
      appBar: StyledAppBar(
          context, volunteer.name, leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back))),
        body: ListView.builder(
          itemCount: volunteerData.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text("${volunteerData.keys.elementAt(index)}: ${volunteerData.values.elementAt(index)}", textDirection: TextDirection.rtl,),
            );
        },)
    );
  }
}
