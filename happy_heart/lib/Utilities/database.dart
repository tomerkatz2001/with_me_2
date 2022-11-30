import '../header.dart';

getAllEquipment() async{
  var data = (await FirebaseFirestore.instance.collection("equipment").get()).docs;
  var equipment=[];
  data.forEach((element) {equipment.add(element.data());});
  return equipment;
}