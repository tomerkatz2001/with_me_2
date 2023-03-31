import '../header.dart';
class DB {

  static insertAvatar(AvatarData data, String uid){
    FirebaseFirestore.instance.collection("avatars").doc(uid).set({
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

  static addAvatarCash(int extra, String uid,BuildContext context) async{
    Future.delayed(Duration(milliseconds: 500),(){showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                    width:MediaQuery.of(context).size.width*0.8,
                    height:MediaQuery.of(context).size.height*0.7,
                    decoration: BoxDecoration(
                      // color: Colors.green,

                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color:  Color(0xff35258a), width: 3, ),
                      color: Color(0xfff4f4f4),
                    ),

                    child:Stack(children: [
                      Align(
                        alignment: FractionalOffset.bottomRight,
                        child: Container(
                          child: FittedBox(
                            child: Image.asset('images/money.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ), Positioned(
                          bottom: 0.5*0.65* MediaQuery.of(context).size.height,
                          left: 0,
                          right:0,
                          top:0,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                              children:[  Text(
                                "יאייייי!",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.assistant(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),),Text(
                                " זכית ב-"+extra.toString()+" "+" מטבעות",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.assistant(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),),Text(
                                "השתמשו בהם בחוכמה ;]",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.assistant(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),)

                              ]
                          )
                      )
                    ]
                      ,)
                )
            )
    );
    }
    );
    var docRef= (await FirebaseFirestore.instance.collection("avatars").doc(uid));

    DocumentSnapshot documentSnapshot = await docRef.get();

    Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
    data['money'] += 10;

    await docRef.update(data);
  }

  static Future<AvatarData?> getAvatar(String uid) async{
    var v =
    (await FirebaseFirestore.instance.collection("avatars").doc(uid).get());
    if (!v.exists){
      return null;
    }
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
  static Stream<QuerySnapshot> getMissions(String uid){
    print("hereee");
    print(uid);
    return FirebaseFirestore.instance.collection("missions").where(
        "uid", isEqualTo: uid).snapshots();
  }

  static setMissionDone(String missionId,int left,String uid, BuildContext context) async {
    print("Donezo!");
    print(missionId);
    print(left);
    if(left<=0){
      addAvatarCash(10, uid, context);
      await FirebaseFirestore.instance.collection("missions")
          .doc(missionId).delete();
    }else {
      await FirebaseFirestore.instance.collection("missions")
          .doc(missionId)
          .update({"amount": left});
    }
  }
}