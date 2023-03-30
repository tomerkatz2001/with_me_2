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
        Column(children: [Text(stations[0].name), Text(stations[0].time)]));
    int c = 0;
    stations.forEach((station) {
      if (c != 0) {
        texts.add(Container(height: 90));
        texts.add(Column(children: [Text(station.name), Text(station.time)]));
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
              Positioned(
                  child: Container(
                      width: 300,
                      height: 700,
                      child: SingleChildScrollView(
                          child: Positioned(
                              child: Container(
                                  child: visitsCourse([
                                Station("בדיקת דם", "באר שבע", "5:00"),
                                Station("MRI", "באר שבע", "5:00"),
                                Station("בדיקת ראש", "באר שבע", "5:00"),
                                Station("בדיקת דם", "באר שבע", "5:00"),
                                Station("MRI", "באר שבע", "5:00"),
                                Station("בדיקת ראש", "באר שבע", "5:00"),
                              ], 0)),
                              right: 20,
                              top: 200))),
                  top: 150,
                  right: -150)
            ],
            context));
  }
}
