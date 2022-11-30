import 'package:happy_heart/Utilities/database.dart';

import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget equipmentListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      final List equipment=snapshot.data;
      return ListView.builder(
          itemCount: equipment.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Center(child:ListTile(
                title:Text(equipment[index]['name']),
                subtitle:Text(equipment[index]['state'])
            ));
          }
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  final Future equipmentFuture = getAllEquipment();

  late FutureBuilder equipmentListFutureBuilder;

  @override
  void initState() {
    super.initState();
    equipmentListFutureBuilder=FutureBuilder(
        future: equipmentFuture,
        builder: equipmentListBuilder
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Happy Heart"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            VerticalSpacer(50),
            const Text('Your equipment:'),
            VerticalSpacer(50),
            equipmentListFutureBuilder
          ],
        ),
      ),
    );
  }
}
