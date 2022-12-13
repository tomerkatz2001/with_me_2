import 'package:happy_heart/Components/addable_list.dart';
import 'package:happy_heart/Components/appbar.dart';

import '../header.dart';

class AddTypePage extends StatefulWidget {
  const AddTypePage({Key? key}) : super(key: key);

  @override
  State<AddTypePage> createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  void addField() {
    setState(() {
      fields.add(_textController.text);
      _textController.clear();
    });
  }

  Widget fieldsListBuilder(BuildContext context, int index) {
    return ListTile(
      title: Text(fields[index]),
    );
  }

  void onSendClicked() async {
    EquipmentType newType = EquipmentType(nameController.text, fields);
    await DB.insertType(newType);
    Navigator.of(context).pop();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  List<String> fields = [];

  EquipmentState state = EquipmentState.NEW;
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String emptyFieldMessage = "please fill in this field";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(context, "סוג ציוד חדש",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          VerticalSpacer(20),
          Input(nameController, "שם סוג הציוד", errorText: emptyFieldMessage, width:300),
          VerticalSpacer(20),
          Input(_textController, "שדה חדש לציוד"),
          VerticalSpacer(20),
          Button(addField,'הוסף שדה'),
          Expanded(
            child: ListView.builder(
              itemCount: fields.length,
              itemBuilder: fieldsListBuilder,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[Button(onSendClicked, "שלח")])),
        ],
      )),
    );
  }
}
