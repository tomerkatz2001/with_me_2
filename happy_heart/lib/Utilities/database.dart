

import '../header.dart';

class DB {
  static Future<int> getPermissions(String uid) async{
    DocumentSnapshot perm = await FirebaseFirestore.instance.collection("users"+ENV).doc(uid).get();
    if(!perm.exists){
      print("A");
      return -2;
    }
    Map data = perm.data() as Map;
    print(data);
    return data['permission'];
  }

  static insertUser(String uid, String name) async{
    await FirebaseFirestore.instance.collection("users"+ENV).doc(uid).set(
      {'name': name, 'permission':-1}
    );
  }

  static setUserPermissions(String uid, int perm){
    if(perm<0){
      FirebaseFirestore.instance.collection("users"+ENV).doc(uid).delete();
    }
    else{
      FirebaseFirestore.instance.collection("users"+ENV).doc(uid).update({'permission': perm});
    }
  }

  static Stream<QuerySnapshot> getUsersByPermissions(int permissions) {

    return FirebaseFirestore.instance.collection("users"+ENV).where(
          "permission", isEqualTo: permissions).snapshots();
  }


  static Stream<QuerySnapshot> getEquipmentStream({type = ""}) {
    if (type == "") {
      return FirebaseFirestore.instance.collection("equipment"+ENV).snapshots();
    } else {
      return FirebaseFirestore.instance.collection("equipment"+ENV).where(
          "name", isEqualTo: type).snapshots();
    }
  }

  static Stream<QuerySnapshot> getTypesStream({type = ""}) {
      return FirebaseFirestore.instance.collection("types"+ENV).snapshots();
  }

  static Future<List<String>> getTypes() async {
    QuerySnapshot<Map<String, dynamic>> allTypesDocs = await FirebaseFirestore.instance.collection("types"+ENV).get();
    List<String> typeList=[];
    allTypesDocs.docs.forEach((element) {
      if(element.data().containsKey("name")){
        typeList.add(element.data()["name"]);
      }
    });
    return typeList;
  }
  static Future<DocumentSnapshot<Map<String,dynamic>>> getTypeFuture({type = " "}) {
    return FirebaseFirestore.instance.collection("types"+ENV).doc(type).get();
  }

  static insertEquipment(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment"+ENV).add(equipment.toMap());
  }

  static updateEqupment(MedicalEquipment equipment) async{
    await FirebaseFirestore.instance.collection("equipment"+ENV).doc(equipment.id).update(equipment.toMap());
  }

  static setAvailable(MedicalEquipment equipment) async {
    await FirebaseFirestore.instance.collection("equipment"+ENV)
        .doc(equipment.id)
        .update({"available": !equipment.available});
  }

  static insertType(EquipmentType type) async {
    await FirebaseFirestore.instance.collection("types"+ENV).doc(type.name).set(
        type.toMap());
  }

  static uploadImage(Uint8List? file, {String currentPath = ""}) async {

    if(file == null){
      return "images/no_image_available.jpg";
    }

    var path;
    if(currentPath != "") {
      path = currentPath;
    } else {
      path = "images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    }

    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to "item.jpg"
    final itemRef = storageRef.child(path);
    
    await itemRef.putData(file!);
    return path;
  }

  static Future<String> downloadImage(String? path) async {

    path ??= "images/no_image_available.jpg";

    final storageRef = FirebaseStorage.instance.ref();
    final itemRef = storageRef.child(path);
    return await itemRef.getDownloadURL();
  }

  static insertDelivery(Delivery delivery) async{
    await FirebaseFirestore.instance.collection("deliveries"+ENV).doc("${delivery.productId}.del").set(
        delivery.toJson()
    );
  }

  static Stream<QuerySnapshot<Delivery>>getDeliveriesSteam({filter=""}){
    var ref = FirebaseFirestore.instance.collection("deliveries"+ENV).withConverter(
        fromFirestore: (snapshot, _) => Delivery.fromJson(snapshot.data()!),
        toFirestore: (delivery, _) => delivery.toJson(),);

    if(filter=="") {
      return ref.snapshots();
    }
    return ref.where("status", isEqualTo: filter).snapshots();
  }



  static void updateDeliveryStatusAndOwner(Delivery delivery, String uid, String newStatus ) async{
    delivery.status= newStatus;
    delivery.ownerId=uid;
    await FirebaseFirestore.instance.collection("deliveries"+ENV).doc("${delivery.productId}.del").set(
        delivery.toJson()
    );
  }

  static void setDeliveryFinished(Delivery delivery, String uid ) async{
    updateDeliveryStatusAndOwner(delivery, uid, "delivered");
  }
  static void setDeliveryStarted(Delivery delivery, String uid ) async{
    updateDeliveryStatusAndOwner(delivery, uid, "onDelivery");
  }

}