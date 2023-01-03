import 'package:happy_heart/header.dart';

ListTile equipmentListTile(MedicalEquipment equipment ,{ GestureTapCallback? onTap}) {
  StringBuffer data = StringBuffer();
  equipment.fields.forEach((key, value) {data..write(key)..write(' : ')..write(value)..write('\n'); });
  print(data);
  return ListTile(
      leading:
      GestureDetector(
        child:
        equipment.available?const Icon(
          Icons.check_box_outline_blank,
          color: Colors.amber,
          size: 24.0,
        ):const Icon(
          Icons.check_box,
          color: Colors.amber,
          size: 24.0,
        ),
      ),
      title:Text(equipment.type, textDirection: TextDirection.rtl),
      subtitle: Text(data.toString(), textDirection: TextDirection.rtl) ,
      onTap: onTap

  );
}




