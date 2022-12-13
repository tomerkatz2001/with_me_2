import 'package:happy_heart/header.dart';
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
                  Icons.accessibility_new_outlined,
                  color: Colors.green,
                  size: 24.0,
                ):const Icon(
                  Icons.accessibility_new_outlined,
                  color: Colors.red,
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