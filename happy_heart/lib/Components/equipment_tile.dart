import 'package:happy_heart/header.dart';

ListTile equipmentListTile(MedicalEquipment equipment ,{ GestureTapCallback? onTap}) {
  // StringBuffer data = StringBuffer();
  // equipment.fields.forEach((key, value) {data..write(key)..write(' : ')..write(value)..write('\n'); });
  // print(data);
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
      GestureDetector(
        onTap: onTap,
        child:
        equipment.available?const Icon(
          Icons.check_box_outline_blank,
          color: Colors.amber,
          size: 24.0,
        ):const Icon(
          Icons.check_box,
          color: Colors.amber,
          size: 24.0,
        )
      ),
      title:Text(equipment.type, textDirection: TextDirection.rtl),
      subtitle: Text(equipment.available? "פנוי" : "תפוס", textDirection: TextDirection.rtl) ,

  );
}




