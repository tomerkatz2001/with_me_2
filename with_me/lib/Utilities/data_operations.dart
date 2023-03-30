import '../header.dart';

Map getTypesMapFromEquipmentList(List equipment){
  Map dict={};
  for(var item in equipment){
    if(dict.containsKey(item['name'])){
      dict[item['name']].add(item);
    }else{
      dict[item['name']]=[item];
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