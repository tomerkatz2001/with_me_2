import 'package:happy_heart/header.dart';

ListTile equipmentListTile(MedicalEquipment equipment ,{ GestureTapCallback? onTap, bool showAccess = true , showDatainDesc = false }) {
  StringBuffer data = StringBuffer();
  if(showDatainDesc){
    equipment.fields.forEach((key, value) { if(key!="available"){data..write(key)..write(' : ')..write(value)..write('\n'); }});
  }
  return ListTile(
      trailing:
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: FutureBuilder(
            future: DB.downloadImage(equipment.fields["image"]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Image.network(snapshot.data!);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
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




