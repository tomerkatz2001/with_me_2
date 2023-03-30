import 'package:with_me/header.dart';
ElevatedButton Button(void Function() onPressed, String text){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(

      foregroundColor: Colors.white,
      backgroundColor: Colors.amber[900]?.withOpacity(0.5),
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
    onPressed: onPressed,
    child: Text(text, textAlign: TextAlign.center,),
  );
}