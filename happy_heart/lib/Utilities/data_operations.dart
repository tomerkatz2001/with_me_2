import '../header.dart';

Map getTypesMapFromEquipmentList(List equipment){
  Map dict={};
  for(var item in equipment){
    if(dict.containsKey(item['name'])){
      dict[item['name']].add(MedicalEquipment.fromMap(item.data(), item.id));
    }else{
      dict[item['name']]=[MedicalEquipment.fromMap(item.data(), item.id)];
    }
  }
  return dict;
}
List<MedicalEquipment> getMedicalEquipmentListFromData(List<QueryDocumentSnapshot<dynamic>> data){
  List<MedicalEquipment> equipment=[];
  for(QueryDocumentSnapshot<dynamic> equipment_data in data){
    equipment.add(MedicalEquipment.fromMap(equipment_data.data(),equipment_data.id));
  }
  return equipment;
}