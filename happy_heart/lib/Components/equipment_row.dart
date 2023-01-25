import 'package:happy_heart/header.dart';

ListTile buildEquipmentRow(BuildContext context , String name, int itemsCount){
  return ListTile(
      leading:
      //TODO: add option to make an item taken
      GestureDetector(
        child:const Icon(
          Icons.arrow_back_ios,
          size: 24.0,
        ),
        onTap: (){},
      ),
      title:Text(name, textDirection: TextDirection.rtl),
      subtitle:Text(itemsCount.toString(), textDirection: TextDirection.rtl),
      onTap: ()=>{
        Navigator.of(context).pushNamed('/equipment_type',arguments:EquipmentTypeArguments(name))
      }
  );
}