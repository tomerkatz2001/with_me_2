import '../header.dart';

class AddDeliveryPage extends StatefulWidget {
  const AddDeliveryPage({Key? key}) : super(key: key);

  @override
  State<AddDeliveryPage> createState() => _AddDeliveryPageState();
}

class _AddDeliveryPageState extends State<AddDeliveryPage> {
  AddressLocation? src;
  AddressLocation? dst;
  MedicalEquipment? sent_obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(context, 'שינוע חדש',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))),
        body: SingleChildScrollView(child: Column(
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
            EquipmentSearch(
              text: 'מוצר',
              onTap: (x) {
                sent_obj = x;
              },
            ),
            VerticalSpacer(20),
            ElevatedButton(
                onPressed: () {
                  if (src == null || dst == null || sent_obj == null) {
                    return;
                  }
                  DB.insertDelivery(
                      Delivery(src!, dst!, sent_obj!.id, sent_obj!.type));
                  Navigator.pop(context);
                },
                child: Text('שלח'))
          ],
        )
          ,)

        );
  }
}
