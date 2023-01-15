import 'package:happy_heart/header.dart';

Widget EquipmentTypeList(List<MedicalEquipment> equipment, Function setStateParent) {
  return ListView.builder(
      itemCount: equipment.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var current = equipment[index];
        return Material(
          child: GestureDetector(
              child:Center(
                child: Hero(tag:index.toString(), child: equipmentListTile(current, onTap: () {current.setAvailable();}))),
              onTap: (){
                // Navigator.of(context).pushNamed('/equipment',
                //     arguments: EquipmentArguments(
                //       equipment[index],
                //       setStateParent,
                //     ));
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return Hero(tag: index.toString(), child: EquipmentPage(EquipmentArguments(
                            equipment[index],
                            setStateParent,
                          )));
                }));
              },
          ),
        );
      });
}
