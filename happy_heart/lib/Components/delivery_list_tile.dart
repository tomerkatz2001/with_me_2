import 'package:happy_heart/header.dart';

class DeliveryListTile extends StatelessWidget {
  Delivery delivery;
  DeliveryListTile(this.delivery, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:  Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          isThreeLine: true,
          title: Text(delivery.getDescription()),
          subtitle: Text(delivery.getLocationDescription() + "\n" + delivery.getDateDescription()),
          trailing: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
