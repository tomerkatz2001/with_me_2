import '../header.dart';
class DB {

  static Future<int> getPermissions(String uid) async{
    DocumentSnapshot perm = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map data = perm.data() as Map;
    return data['permission'];
  }

  static insertUser(String uid, String name) async{
    await FirebaseFirestore.instance.collection("users").doc(uid).set(
      {'name': name, 'permission':-1}
    );
  }

  static setUserPermissions(String uid, int perm){
    if(perm<0){
      FirebaseFirestore.instance.collection("users").doc(uid).delete();
    }
    else{
      FirebaseFirestore.instance.collection("users").doc(uid).update({'permission': perm});
    }
  }

  static Stream<QuerySnapshot> getUsersByPermissions(int permissions) {

    return FirebaseFirestore.instance.collection("users").where(
          "permission", isEqualTo: permissions).snapshots();
  }


  static Stream<QuerySnapshot> getEquipmentStream({type = ""}) {
    if (type == "") {
      return FirebaseFirestore.instance.collection("equipment").snapshots();
    } else {
      return FirebaseFirestore.instance.collection("equipment").where(
          "name", isEqualTo: type).snapshots();
    }
  }

  static Stream<QuerySnapshot> getTypesStream({type = ""}) {
      return FirebaseFirestore.instance.collection("types").snapshots();
  }

  static Future<List<String>> getTypes() async {
    QuerySnapshot<Map<String, dynamic>> allTypesDocs = await FirebaseFirestore.instance.collection("types").get();
    List<String> typeList=[];
    allTypesDocs.docs.forEach((element) {
      if(element.data().containsKey("name")){
        typeList.add(element.data()["name"]);
      }
    });
    return typeList;
  }
  static Future<DocumentSnapshot<Map<String,dynamic>>> getTypeFuture({type = " "}) {
    return FirebaseFirestore.instance.collection("types").doc(type).get();
  }

  static insertEquipment(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment").add(equipment.toMap());
  }

  static setAvailable(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment")
        .doc(equipment.id)
        .update({"available": !equipment.available});
  }

  static insertType(EquipmentType type) async {
    await FirebaseFirestore.instance.collection("types").doc(type.name).set(
        type.toMap());
  }
}