import 'package:happy_heart/header.dart';

ListTile equipmentListTile(MedicalEquipment equipment ,{ GestureTapCallback? onTap, bool showAccess = true , showDatainDesc = false }) {
  StringBuffer data = StringBuffer();
  if(showDatainDesc){
    equipment.fields.forEach((key, value) { if(key!="available"){data..write(key)..write(' : ')..write(value)..write('\n'); }});
  }
  return ListTile(
      leading:
      showAccess?GestureDetector(
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
          onTap: onTap
      ):Container(
        width: 24.0,
        height: 24.0,
      ),
      title:Text(equipment.type, textDirection: TextDirection.rtl),
      subtitle: Text(showDatainDesc?data.toString():equipment.available? "פנוי" : "תפוס", textDirection: TextDirection.rtl) ,

  );
}




