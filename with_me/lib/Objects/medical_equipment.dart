import 'package:with_me/header.dart';

class MedicalEquipment{
  String type;
  String id;
  bool available;
  Map<String,dynamic> fields;
  MedicalEquipment(this.type,this.id, {this.available=true,this.fields =const {}}){}
  Map<String, dynamic> toMap(){
    var map= {"name":type,"available":available};
    fields.keys.forEach((element) {map[element]=fields[element];});
    return map;
  }
  MedicalEquipment.fromMap(Map<String,dynamic> data,String id):
    this(
          data["name"],
          id,
          available: data.containsKey("available")?data["available"]:true,
      );
  setAvailable(){
    DB.setAvailable(this);
  }
}
