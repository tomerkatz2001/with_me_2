import 'package:happy_heart/header.dart';

Widget fieldsListTile(MapEntry<String,dynamic> entry ,{ GestureTapCallback? onTap}) {
  return ListTile(
      title:Text(entry.key, textDirection: TextDirection.rtl),
      subtitle: Text(entry.value.toString(), textDirection: TextDirection.rtl) ,
      onTap: onTap
  );
}




