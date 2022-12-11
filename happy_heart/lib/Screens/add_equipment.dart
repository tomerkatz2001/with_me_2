
import 'package:happy_heart/Components/appbar.dart';

import '../header.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  final nameController = TextEditingController();
  final stateController = TextEditingController();
  EquipmentState state = EquipmentState.NEW;
  @override
  void dispose() {
    nameController.dispose();
    stateController.dispose();
    super.dispose();
  }

  String emptyFieldMessage = "please fill in this field";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: StyledAppBar(context,"ציוד חדש" , leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back))),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.end,
            children: <Widget>[
              Center(child:Image.asset('assets/lev-hedva.png')),
              VerticalSpacer(5),
              Input(nameController, "סוג הציוד",
                  errorText: emptyFieldMessage),

              VerticalSpacer(5),
              DropdownButton<EquipmentState>(
          value: state,
              onChanged: (EquipmentState? newValue) {
            if(newValue!=null) {
              state = newValue;
            } else{
              state = EquipmentState.NEW;
            }
          },
          items: EquipmentState.values.map((EquipmentState state) {
          return DropdownMenuItem<EquipmentState>(
          value: state,
          child: Text(state.name));
          }).toList()),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Button( () async {
                            MedicalEquipment new_equipment = MedicalEquipment(nameController.text,"new",state: stateFromTitle(stateController.text));
                            await DB.insertEquipment(new_equipment);
                            Navigator.of(context).pop();
                          }, "הוסף")
                      ]
                  )
              ),
            ],
          )
      ),
    );
  }
}