import '../header.dart';

class AddDeliveryPage extends StatefulWidget {
  const AddDeliveryPage({Key? key}) : super(key: key);

  @override
  State<AddDeliveryPage> createState() => _AddDeliveryPageState();
}

class _AddDeliveryPageState extends State<AddDeliveryPage> {
  AddressLocation? src;
  AddressLocation? dst;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(context, 'שינוע חדש',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))),
        body: Column(
          children: <Widget>[
            VerticalSpacer(20),
            GMapsSearch(
              text: 'מוצא',
              onTap: (x) {
                src = x;
              },
            ),
            VerticalSpacer(20),
            GMapsSearch(
              text: 'יעד',
              onTap: (x) {
                dst = x;
              },
            ),
            VerticalSpacer(20),
            Input(nameController, 'סוג'),
            VerticalSpacer(20),
            ElevatedButton(
                onPressed: () { if(src==null || dst==null){return;}
                  DB.insertDelivery(Delivery(
                      src!,
                      dst!,
                      "productId",
                      nameController.text));
                },
                child: Text('שלח'))
          ],
        ));
  }
}
