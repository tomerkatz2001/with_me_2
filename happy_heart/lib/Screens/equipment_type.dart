
import 'package:happy_heart/Components/type_list.dart';

import '../header.dart';

class EquipmentTypeArguments {
  final String name;
  EquipmentTypeArguments(this.name);
}

class EquipmentTypePage extends StatefulWidget {
  const EquipmentTypePage({super.key});
  @override
  State<EquipmentTypePage> createState() => _EquipmentTypePageState();
}

class _EquipmentTypePageState extends State<EquipmentTypePage> {

  Widget equipmentListBuilder(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      if(snapshot.data!=null ) {
        if(snapshot.data?.docs!=null) {
          final List<
              MedicalEquipment> equipment = getMedicalEquipmentListFromData(
              snapshot.data!.docs);
          return EquipmentTypeList(equipment);
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
    final arguments = ModalRoute.of(context)!.settings.arguments as EquipmentTypeArguments;
    equipmentStream=DB.getEquipmentStream(type: arguments.name);
    equipmentListStreamBuilder=StreamBuilder<QuerySnapshot>(
        stream: equipmentStream,
        builder: equipmentListBuilder
    );

    return Scaffold(
      appBar: StyledAppBar(context, arguments.name,
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
            Text((arguments.name+' שנמצאים כרגע במלאי: ') , textDirection: TextDirection.rtl),
            VerticalSpacer(50),
            Expanded(child: equipmentListStreamBuilder)
          ],
        ),
      ),
    );
  }
}