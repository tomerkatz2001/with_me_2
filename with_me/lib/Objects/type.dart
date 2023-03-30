import 'package:with_me/header.dart';
class EquipmentType{
  List<String> fields=[];
  String name="";
  EquipmentType(this.name,this.fields);
  EquipmentType.fromMap(Map<String,dynamic> data,String id):
        this(
          data["name"],
          data["fields"]
      );
  Map<String, dynamic> toMap(){
    return {"name":name,"fields":fields};
  }
}