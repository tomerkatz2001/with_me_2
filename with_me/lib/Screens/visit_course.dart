import '../header.dart';

class VisitCoursePage extends StatefulWidget {
  const VisitCoursePage({super.key});

  @override
  State<VisitCoursePage> createState() => _VisitCoursePageState();
}

class _VisitCoursePageState extends State<VisitCoursePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget visitsCourse(List<Station> stations, int current_index) {

    var childs = [
      SizedBox(
        height: 30,
        child: VerticalDivider(
          width: 3,
          color: Colors.grey,
        ),
      ),
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: current_index == 0 ? Colors.red : Colors.amberAccent,
        ),
      )
    ];
    List<Widget> texts = [];
    texts.add(
        Column(children: [Text(stations[0].name??"אין שם"), Text(stations[0].time??"אין זמן מוערך")]));
    int c = 0;
    stations.forEach((station) {
      if (c != 0) {
        texts.add(Container(height: 90));
        texts.add(Column(children: [Text(station.name??"אין שם"), Text(station.time??"אין זמן מוערך")]));
        childs.add(SizedBox(
          height: 100,
          child: VerticalDivider(
            width: 3,
            color: Colors.grey,
          ),
        ));
        childs.add(Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c == current_index ? Colors.red : Colors.amber,
          ),
        ));
      }
      c += 1;
    });
    childs.add(SizedBox(
      height: 30,
      child: VerticalDivider(
        width: 3,
        color: Colors.grey,
      ),
    ));
    return Row(children: [
      Column(
        children: texts,
      ),
      Container(width: 10),
      Column(
        children: childs,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularAppBar(
            "הביקור שלי",
            [

              StreamBuilder<QuerySnapshot<Object?>>(
                stream: DB.getPatient(context.read<FirebaseAuthMethods>().user.email!),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
                    ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      var x = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                      Patient p = Patient.fromMap(x , "tmp");
                      List<Station> stations = p.dayTasks??[];
                      if(stations.isEmpty)
                      {
                        print("empty!!!!!!!!!!!!!!!");
                        return Column(
                          children: [
                            SizedBox(height: 350,),
                            Center(child: Text("אין לך דברים לעשות!"),),
                          ],
                        );
                      }

                      return Stack(
                      children: [
                      Positioned(
                        top: 150,
                        right: -150,
                        child: SizedBox(
                            width: 300,
                            height: 700,
                            child: SingleChildScrollView(
                                child: Positioned(
                                    right: 20,
                                    top: 200,
                                    child: Container(
                                        child: visitsCourse(stations, 0))))),
                      ),
                      Align(
                   child: Container(
                     width: MediaQuery.of(context).size.width*0.4,
                     height: MediaQuery.of(context).size.width*0.4,
                     child: AvatarStack(
                         data: (AvatarData.currAvatar ??
                             AvatarData(body: AvatarData.body_default))..hands='images/handsdown.png')),
                   alignment: Alignment.bottomLeft,
                 )
                      ]);
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },

              )
            ],
            context));
  }
}
