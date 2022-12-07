
import '../header.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  final nameController = TextEditingController();
  final stateController = TextEditingController();
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
      appBar: AppBar(title: Text("Insert equipment")),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: <Widget>[
              Align(alignment: Alignment.center,child:Text("Insert equipment")),
              VerticalSpacer(5),
              Image.asset('assets/lev-hedva.png'),
              VerticalSpacer(5),
          Input(nameController, "Equipment name",
                  errorText: emptyFieldMessage),
              Input(stateController, "State",
                  errorText: emptyFieldMessage),
              VerticalSpacer(5),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton( onPressed: () async {
                            await insertEquipment({
                            "name":nameController.text,
                            "state":stateController.text
                            });
                            Navigator.of(context).pop();
                            setState(() {});
                          }, child: Text("Add item"))
                      ]
                  )
              ),
            ],
          )
      ),
    );
  }
}