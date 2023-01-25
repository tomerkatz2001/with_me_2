import 'package:happy_heart/Components/floating_action_button.dart';
import 'package:happy_heart/Components/type_list.dart';

import '../header.dart';

class EquipmentTypePage extends StatefulWidget {
  const EquipmentTypePage({super.key});
  @override
  State<EquipmentTypePage> createState() => _EquipmentTypePageState();
}

class _EquipmentTypePageState extends State<EquipmentTypePage> {
    void equipmentTypePageSetState() {
      setState(() {});
    }

  Widget equipmentListBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data != null) {
        if (snapshot.data?.docs != null) {
          final List<MedicalEquipment> equipment =
              getMedicalEquipmentListFromData(snapshot.data!.docs);
          return EquipmentTypeList(equipment, equipmentTypePageSetState);
        }
      }
    }
    return const Center(child: CircularProgressIndicator());
  }

  late Stream<QuerySnapshot> equipmentStream;

  late StreamBuilder equipmentListStreamBuilder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as EquipmentTypeArguments;
    String name = arguments.name;
    equipmentStream = DB.getEquipmentStream(type: arguments.name);
    equipmentListStreamBuilder = StreamBuilder<QuerySnapshot>(
        stream: equipmentStream, builder: equipmentListBuilder);

    return Scaffold(
      appBar: StyledAppBar(context, arguments.name,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text((arguments.name + ' שנמצאים כרגע במלאי: '),
                textDirection: TextDirection.rtl),
            VerticalSpacer(50),
            Expanded(child: equipmentListStreamBuilder)
          ],
        ),
      ),
      floatingActionButton: FloatingButton(
        () {
          Navigator.of(context).pushNamed("/add_equipment",
              arguments: EquipmentTypeArguments(name));
        },
      ),
    );
  }
}
