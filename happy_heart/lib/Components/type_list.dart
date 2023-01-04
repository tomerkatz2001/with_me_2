import 'package:happy_heart/header.dart';

Widget EquipmentTypeList(List<MedicalEquipment> equipment) {
  return ListView.builder(
      itemCount: equipment.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var current = equipment[index];
        return GestureDetector(
            child:Center(
              child: equipmentListTile(current, onTap: () {current.setAvailable();})),
            onTap: (){
              Navigator.of(context).pushNamed('/equipment',
                  arguments: EquipmentArguments(
                    equipment[index]
                  ));
            },
        );
      });
}
