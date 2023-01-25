import 'package:happy_heart/header.dart';
Future<void> showDeliveryDialog(context, Delivery delivery,onPressed,text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
        Text(delivery.getDescription(),
            textDirection: TextDirection.rtl
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(delivery.getLocationDescription(),
                  textDirection: TextDirection.rtl),
            ],
          ),
        ),
        actions: <Widget>[
          Button((){onPressed();Navigator.pop(context);}, text),
        ],
      );
    },
  );
}
