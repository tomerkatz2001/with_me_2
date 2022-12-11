
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
      Map dict = getTypesMapFromEquipmentList(equipment);
      return ListView.builder(
          itemCount: dict.entries.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var current=dict.keys.elementAt(index);
            return Center(child:ListTile(
                leading:
                    //TODO: add option to make an item taken
                GestureDetector(
                  child:const Icon(
                  Icons.arrow_back_ios,
                  size: 24.0,
                ),
                    onTap: (){},
                ),
                title:Text(current, textDirection: TextDirection.rtl),
                subtitle:Text(dict[current].length.toString(), textDirection: TextDirection.rtl),
                onTap: ()=>{
                  Navigator.of(context).pushNamed('/equipment_type',arguments:EquipmentTypeArguments(current))
                }
            ));
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
