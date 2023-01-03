
import '../header.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});
  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!(ModalRoute.of(context)!.settings.arguments is EquipmentArguments)){
      Navigator.of(context).pop();
    }
    final arguments =
        ModalRoute.of(context)!.settings.arguments as EquipmentArguments;
    MedicalEquipment equipment = arguments.equipment;
    List<MapEntry<String,dynamic>> fieldsList = equipment.fields.entries.toList();
    return Scaffold(
      appBar: StyledAppBar(context, equipment.type,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            VerticalSpacer(10),
            Expanded(child: ListView.builder(
                itemCount: fieldsList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var current = fieldsList[index];
                  if(current.key!="available") {
                    return Center(
                        child: fieldsListTile(current));
                  }else{
                    return Container();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
