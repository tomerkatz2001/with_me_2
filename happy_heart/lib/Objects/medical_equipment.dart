import 'package:happy_heart/header.dart';

class MedicalEquipment{
  String type;
  String id;
  bool available;
  String currentLocation;
  EquipmentState state;
  MedicalEquipment(this.type,this.id, {this.available=true, this.currentLocation="Nehariya", this.state=EquipmentState.NEW}){}
  Map<String, dynamic> toMap(){
    return {"name":type,"available":available,"currentLocation":currentLocation,"state":state.name};
  }
  MedicalEquipment.fromMap(Map<String,dynamic> data,String id):
    this(
          data["name"],
          id,
          available: data.containsKey("available")?data["available"]:true,
          currentLocation : data.containsKey("currentLocation")?data["currentLocation"]:"Netanya",
          state : data.containsKey("state")?stateFromTitle(data["state"]):EquipmentState.NEW
      );
  setAvailable(){
    DB.setAvailable(this);
  }
}
