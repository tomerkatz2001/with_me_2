
import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget equipmentListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      final List equipment=snapshot.data!.docs;
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

  final Stream equipmentStream = getEquipmentStream();

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
      appBar: AppBar(
        title: Text("Happy Heart"),
        elevation: 0,
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
            Image.asset('assets/lev-hedva.png'),
            VerticalSpacer(50),
            const Text('Your equipment:'),
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
