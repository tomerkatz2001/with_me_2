import 'package:happy_heart/Components/appbar.dart';

import '../header.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {

  var _image = null;

  onSendPressed() async {
    Map<String, dynamic> fieldsMap = {};

    for (int i = 0; i < fields.length; i++) {
      fieldsMap[fields[i]] = fieldsControllers[i].text;
    }

    // upload image to firebase storage
    final path = await DB.uploadImage(_image);

    fieldsMap["image"] = path;

    MedicalEquipment new_equipment =
        MedicalEquipment(typeName, "new", fields: fieldsMap);
    await DB.insertEquipment(new_equipment);
    Navigator.of(context).pop();
  }

  Widget fieldsBuilder(BuildContext context,
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> document) {
    if (document.hasData) {
      fields = document.data?.data()?["fields"];
      fieldsControllers = [];
      fields.forEach((element) {
        fieldsControllers.add(TextEditingController());
      });
      return ListView.builder(
        shrinkWrap: true,
        itemCount: fields.length,
        itemBuilder: (context, index) {
          return Column(children:[Input(fieldsControllers[index], fields[index]),VerticalSpacer(20)]);
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  String typeName = "";
  late List<dynamic> fields;
  Future<List<String>> typesFuture = DB.getTypes();
  late Future<DocumentSnapshot<Map<String, dynamic>>> fieldsFuture;
  List<TextEditingController> fieldsControllers = [];
  late FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
      fieldsFutureBuilder;

  @override
  void dispose() {
    fieldsControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as EquipmentTypeArguments;
    typeName = arguments.name;

    print("typename:");
    print(typeName);
    fieldsFuture = DB.getTypeFuture(type: typeName);
    fieldsFutureBuilder = FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fieldsFuture, builder: fieldsBuilder);
    return Scaffold(
        appBar: StyledAppBar(context, typeName + " חדש",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))),
        body: Column(
          children: <Widget>[
            VerticalSpacer(20),
            Expanded(
                child: Column(
                  children: [
                    fieldsFutureBuilder,
                    IconButton(onPressed: () async {
                      ImagePicker _picker = ImagePicker();
                      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        _image = await image.readAsBytes();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No image selected"))
                        );
                      }
                    }, icon: Icon(Icons.image),
                      tooltip: "הוסף תמונה",
                      ),
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Button(onSendPressed, "הוסף")])),
          ],
        ));
  }
}
