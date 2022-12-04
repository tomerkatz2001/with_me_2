import '../header.dart';
import '../Components/product_data.dart';

Future<List<MedicalProduct>> getAllEquipment() async{
  var data = (await FirebaseFirestore.instance.collection("equipment").get()).docs;
  List<MedicalProduct> equipment=[];

  data.forEach((element) {equipment.add(MedicalProduct(element.data()['name'], false, 'maalot tarshiha'));});
  return equipment;
}