import '../header.dart';
class DB {

  static insertAvatar(AvatarData data, String uid){
    FirebaseFirestore.instance.collection("avatars").doc(uid).update({
      'body': data.body,
      'glasses': data.glasses,
      'body_color':data.body_color.toString().split('(0x')[1].split(')')[0],
      'purchased' : data.acquired.toString(),
      'hobby':data.hobby,
      'money' : data.money,
      'eye_color': data.eye_color.toString().split('(0x')[1].split(')')[0],
      'pants': data.pants
    });
  }

  static addAvatarCash(int extra, String uid) async{
    var v =
    (await FirebaseFirestore.instance.collection("avatars").doc(uid).get());
    int money=0;
    if(v.data()==null){
    money=0;}
    else {
    money = v['money'];
    }
    print(money);
    money+=extra;
    await FirebaseFirestore.instance
        .collection("avatars")
        .doc(uid)
        .set({'money':money}, SetOptions(merge: true));
  }

  static Future<AvatarData> getAvatar(String uid) async{
    var v =
    (await FirebaseFirestore.instance.collection("avatars").doc(uid).get());
    var a = AvatarData(
    money: v['money'],
    body: v['body'],
    glasses: v['glasses'],
    hobby: v['hobby'],
    eye_color: Color(int.parse(v['eye_color'], radix: 16)),
    body_color: Color(int.parse(v['body_color'], radix: 16)),
    acquired: v.data()!.keys.contains('purchased')?AvatarShop(v['purchased']): AvatarShop.empty(),
    pants: v.data()!.keys.contains('pants')?v["pants"]: null,
    );
    return a;
  }


  static Future<int> getPermissions(String uid) async{
    DocumentSnapshot perm = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map data = perm.data() as Map;
    return data['permission'];
  }

  static insertUser(Client user) async{
    if (user.permission==0) insertPatient(Patient(user.name, user.id, user.email));
    await FirebaseFirestore.instance.collection("users").doc(user.id).set(user.toMap());
  }

  static insertPatient(Patient user) async{
    print('here');
    print(user.toMap().toString());
    await FirebaseFirestore.instance.collection("patients").doc(user.id).set(user.toMap());
    print(user.toMap().toString());

  }


  static setUserPermissions(Client user, int perm){
    if(perm<0){
      FirebaseFirestore.instance.collection("users").doc(user.id).delete();
    }
    else{
      print('perm=0');
      if (perm==0) DB.insertPatient(Patient(user.name, user.id, user.email));
      FirebaseFirestore.instance.collection("users").doc(user.id).update({'permission': perm});
    }
  }

  static Stream<QuerySnapshot> getUsersByPermissions(int permissions) {

    return FirebaseFirestore.instance.collection("users").where(
          "permission", isEqualTo: permissions).snapshots();
  }

  static Stream<QuerySnapshot> getPatients() {

    return FirebaseFirestore.instance.collection("patients").snapshots();
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

  static Stream<QuerySnapshot> getPatient(String patient_email){
    print("hereee");
    print(patient_email);
    return FirebaseFirestore.instance.collection("patients").where(
        "email", isEqualTo: patient_email).snapshots();


  }
}