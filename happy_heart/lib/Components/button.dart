import 'package:happy_heart/header.dart';
MaterialButton Button(void Function() onPressed, String text){
  return MaterialButton( onPressed:onPressed, child: Text(text));
}