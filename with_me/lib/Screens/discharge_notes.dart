import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';
import 'package:with_me/header.dart';

import '../Components/appbar.dart';
import '../Objects/station.dart';

String API_KEY='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';

class DischargePage extends StatefulWidget {
  const DischargePage({super.key});

  @override
  State<DischargePage> createState() => _DischargePageState();
}

class _DischargePageState extends State<DischargePage> {
  @override
  late OpenAIClient client;
  List<String> lines = [];
  bool done=false;
  Future<List<String>> chatgpt() async {
    // Fetch the models.
    if(done){
      return lines;
    }
    done = true;
    final models = await client.models.list().data;

    // Fetch a model by ID.
    final modelId = await client.models.byId(id: 'text-davinci-002').data;
    final completion = await client.chat.create(
      model: 'gpt-3.5-turbo',
      messages: const [
        ChatMessage(
          role: 'system',
          content: """
  מכתב שחרור:
המשך מעקב רופא מטפל

יש לברר את התשובה הפתולוגית/תשובות מעבדה שנלקחו באשפוז

טיפול מקומי - משחת פוסידין פעמיים ביוס, אגד אלסטי, הקפדה על רגל מורמת.
חופש מחלה - 7 ימים

ביקורת מרפאת פלסטיקה במוסדנו בעוד חודש

לתשומת ליבך! בעת השחרור מאשפוז טרס התקבלו כל תוצאות הבדיקות, אשר בוצעו במהלך האישפוז. תוצאות הבדיקות ימסרו בעת הביקור
במרפאה. במידה ולא תואס ביקור במרפאה, יש לפנות לרופא המטפל בקהילה לקבלת התוצאות.

תיצור לי רשימת מטלות
     """,
        )
      ],
    ).data;
    print("JABETTA:");


    lines=completion.choices[0].message.content.split(RegExp(r"(\d+)\. ")).map((s){return s.trim();}).where((s) => s.isNotEmpty as bool).toList();
    print(lines);
    return lines;
    print(lines);
  }

  void initState() {
    super.initState();
    final conf = OpenAIConfiguration(
        organizationId: "org-S1zDIfQUIOHMtiVR9PAWp6wR",
        apiKey: API_KEY);
    client = OpenAIClient(configuration: conf, enableLogging: true);
    // chatgpt();

    // Fetch the models.
  }


  Widget visitsCourse(List<Station> stations, int current_index) {
    var childs = [
      SizedBox(
        height: 30,
        child: VerticalDivider(
          width: 3,
          color: Colors.grey,
        ),
      ),
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: current_index == 0 ? Colors.red : Colors.amberAccent,
        ),
      )
    ];
    List<Widget> texts = [];
    texts.add(
        Column(children: [Text(stations[0].name??"אין שם"), Text(stations[0].time??"הזמן לא נקבע")]));
    int c = 0;
    stations.forEach((station) {
      if (c != 0) {
        texts.add(Container(height: 90));
        texts.add(Column(children: [Text(station.name??"אין שם"), Text(station.time??"הזמן לא נקבע")]));
        childs.add(SizedBox(
          height: 100,
          child: VerticalDivider(
            width: 3,
            color: Colors.grey,
          ),
        ));
        childs.add(Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c == current_index ? Colors.red : Colors.amber,
          ),
        ));
      }
      c += 1;
    });
    childs.add(SizedBox(
      height: 30,
      child: VerticalDivider(
        width: 3,
        color: Colors.grey,
      ),
    ));
    return Row(children: [
      Column(
        children: texts,
      ),
      Container(width: 10),
      Column(
        children: childs,
      ),
    ]);
  }
  List<Item> _data = generateItems(8);



  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularAppBar(
            "הביקור שלי",
            [Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(child: Text('צור משימות'),onPressed: (){
                print('ddddddd');
                MakeTaskPage.Lines=lines;
                Navigator.of(context).pushNamed( '/make_weekly_tasks');
              },),
            ),
              Positioned(
                  top: 150,
                  child: Container(
                      height: 700,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                          child: Container(
                        child: FutureBuilder<List<String>>(
                          future: Future(() async {
                            lines = await chatgpt();
                            return lines;
                          }),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.hasData) {
                              _data = parseItems(snapshot.data!);
                              return _buildPanel();
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      )))),

            ],
            context));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
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
      expandedValue: 'This is item number $index'
    );
  });
}

List<Item> parseItems(List<String> items) {
  List<Item> list=[];
  items.forEach((element) {
    list.add(Item(
      headerValue: element,
      expandedValue: element,
      isExpanded: false
    ));
  });
  return list;
}
