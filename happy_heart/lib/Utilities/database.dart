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

  static insertEquipment(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment").add(
        equipment.toMap());
  }

  static setAvailable(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment")
        .doc(equipment.id)
        .update({"available": !equipment.available});
  }
}