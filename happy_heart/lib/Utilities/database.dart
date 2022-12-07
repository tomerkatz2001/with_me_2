import '../header.dart';

getAllEquipment() async{
  var data = (await FirebaseFirestore.instance.collection("equipment").get()).docs;
  var equipment=[];
  data.forEach((element) {equipment.add(element.data());});
  return equipment;
}

Stream getEquipmentStream(){
  return FirebaseFirestore.instance.collection("equipment").snapshots();
}

insertEquipment(data) async{
  await FirebaseFirestore.instance.collection("equipment").add(data);
}