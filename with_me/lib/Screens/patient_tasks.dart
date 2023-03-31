import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';
import 'package:with_me/header.dart';

import '../Components/appbar.dart';
import '../Components/input.dart';
import '../Objects/station.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  late OpenAIClient client;
  late Stream<QuerySnapshot> missionsStream;
  Widget missionListBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data != null) {
        if (snapshot.data?.docs != null) {
          var data =snapshot.data?.docs;
          print("DDDDDDDDDDDD");
          print(data);
          List<ListTile> tiles =[];
          data?.forEach((element) {
            print("peer tasi");
            print(element.data());
            Map<String,dynamic> dat=element.data() as  Map<String,dynamic>;
            print(dat.keys);
            print(dat["task"]);
            tiles.add(
              ListTile(title:Text(dat["task"]), subtitle: Text(dat["amount"].toString()),trailing: Button((){
                DB.setMissionDone(element.id, dat["amount"]-1,context.read<FirebaseAuthMethods>().user.uid,context);
              },"סיימתי"),)
            );
          });
        return ListView(children: tiles);
        }
      }
    }
    return const Center(child: CircularProgressIndicator());
  }


  void initState() {
    super.initState();
    missionsStream=DB.getMissions(context.read<FirebaseAuthMethods>().user.uid);
  }

  List<Item> _data = generateItems(8);
  var message = "";

  TextEditingController inputMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularAppBar(
            "הביקור שלי",
            [
               Positioned(child: Container(
                   height:700,
                   width: MediaQuery.of(context).size.width,
                   child:StreamBuilder<QuerySnapshot>(
                  stream: missionsStream, builder: missionListBuilder)),
                  top: 150,
                 right:10,
                 left:10
               )
            ],
            context));
  }

}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index');
  });
}

List<Item> parseItems(List<String> items) {
  List<Item> list = [];
  items.forEach((element) {
    list.add(
        Item(headerValue: element, expandedValue: element, isExpanded: false));
  });
  return list;
}
