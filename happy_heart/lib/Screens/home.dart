import '../Components/product_data.dart';
import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget equipmentListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      final List<MedicalProduct> equipment=snapshot.data;
      return ListView.builder(
          itemCount: equipment.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Center(child:ListTile(
                leading: equipment[index].isFree ?
                const Icon(
                  Icons.accessibility_new_outlined,
                  color: Colors.green,
                  size: 24.0,
                ):
                const Icon(
                  Icons.accessible,
                  color: Colors.red,
                  size: 24.0,
                ),
                title:Text(equipment[index].type),
                subtitle:Text(equipment[index].isFree ? 'פנוי' : 'תפוס' ),
                onTap: ()=>{}
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
            equipmentListFutureBuilder
          ],
        ),
      ),
    );
  }
}
