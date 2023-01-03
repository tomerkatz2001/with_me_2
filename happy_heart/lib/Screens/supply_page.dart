import 'package:happy_heart/header.dart';

class SupplyPage extends StatefulWidget {
  const SupplyPage({super.key});

  @override
  State<SupplyPage> createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  Widget typeListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      List types = snapshot.data!.docs;
      types.removeWhere((element) {
        return element.data()["name"] == null;
      });

      return ListView.builder(
          itemCount: types.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var current = types[index];
            return Center(
                child: typeListTile(current.data()["name"],
                    onTap: () => {
                          Navigator.of(context).pushNamed('/equipment_type',
                              arguments: EquipmentTypeArguments(
                                  current.data()["name"]))
                        }));
          });
    }
    return const Center(child: CircularProgressIndicator());
  }

  final Stream typesStream = DB.getTypesStream();

  late StreamBuilder typeListStreamBuilder;

  @override
  void initState() {
    super.initState();
    typeListStreamBuilder =
        StreamBuilder(stream: typesStream, builder: typeListBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          context,
          "לב חדווה",
          actions: [
            GestureDetector(
              child: const Icon(Icons.logout),
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
              Center(child: Image.asset('assets/lev-hedva.png')),
              VerticalSpacer(50),
              const Text('הציוד שנמצא כרגע במלאי:',
                  textDirection: TextDirection.rtl),
              VerticalSpacer(50),
              Expanded(child: typeListStreamBuilder)
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingButton(() {
              Navigator.of(context).pushNamed("/add_type");
            }),
          ],
        ));
  }
}
