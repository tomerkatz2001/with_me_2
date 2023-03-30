import 'package:with_me/header.dart';

displaySnackbar(String text,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}