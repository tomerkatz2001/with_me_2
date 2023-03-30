import 'package:with_me/header.dart';
Widget EquipmentTypeList(List<MedicalEquipment> equipment){
  return ListView.builder(
      itemCount: equipment.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var current=equipment[index];
        return Center(child:ListTile(
            leading:
            GestureDetector(
                child:
                current.available?const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.amber,
                  size: 24.0,
                ):const Icon(
                  Icons.check_box,
                  color: Colors.amber,
                  size: 24.0,
                ),
                onTap: (){
                  current.setAvailable();
                },
            ),
            title:Text(current.type, textDirection: TextDirection.rtl),
            onTap: ()=>{}
        ));
      }
  );
}