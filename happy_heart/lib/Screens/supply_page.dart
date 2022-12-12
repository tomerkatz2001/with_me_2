import 'package:happy_heart/header.dart';


class SupplyPage extends StatefulWidget {
  const SupplyPage({super.key});
  @override
  State<SupplyPage> createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {

  Widget equipmentListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      final List equipment=snapshot.data!.docs;
      Map dict = getTypesMapFromEquipmentList(equipment);
      return ListView.builder(
          itemCount: dict.entries.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var current=dict.keys.elementAt(index);
            return Center(child:buildEquipmentRow(context, current, dict[current].length));
          }
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  final Stream equipmentStream = DB.getEquipmentStream();

  late StreamBuilder equipmentListStreamBuilder;


  @override
  void initState() {
    super.initState();
    equipmentListStreamBuilder=StreamBuilder(
        stream: equipmentStream,
        builder: equipmentListBuilder
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(context, "לב חדווה",
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout, color: Colors.white),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(child:Image.asset('assets/lev-hedva.png')),
            VerticalSpacer(50),
            const Text('הציוד שנמצא כרגע במלאי:' , textDirection: TextDirection.rtl),
            VerticalSpacer(50),
            Expanded(child: equipmentListStreamBuilder)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_equipment");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
