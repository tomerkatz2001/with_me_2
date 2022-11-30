import 'package:happy_heart/header.dart';

displaySnackbar(String text,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}