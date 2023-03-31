
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';

import '../Components/appbar.dart';
import '../Objects/station.dart';


class DischargePage extends StatefulWidget {
  const DischargePage({super.key});
  @override
  State<DischargePage> createState() => _DischargePageState();
}

class _DischargePageState extends State<DischargePage> {
  @override
  late OpenAIClient client;

  Future<List<String>> chatgpt() async{
    // Fetch the models.
    final models = await client.models.list().data;

    // Fetch a model by ID.
    final modelId = await client.models.byId(id: 'text-davinci-002').data;
    final completion = await client.chat.create(
        model: 'gpt-3.5-turbo',
          messages:const [
            ChatMessage(
              role: 'user',
              content:  """
  מכתב שחרור:
המשך מעקב רופא מטפל

יש לברר את התשובה הפתולוגית/תשובות מעבדה שנלקחו באשפוז

טיפול מקומי - משחת פוסידין פעמיים ביוס, אגד אלסטי, הקפדה על רגל מורמת.
חופש מחלה - 7 ימים

ביקורת מרפאת פלסטיקה במוסדנו בעוד חודש

לתשומת ליבך! בעת השחרור מאשפוז טרס התקבלו כל תוצאות הבדיקות, אשר בוצעו במהלך האישפוז. תוצאות הבדיקות ימסרו בעת הביקור
במרפאה. במידה ולא תואס ביקור במרפאה, יש לפנות לרופא המטפל בקהילה לקבלת התוצאות.

תיצור לי רשימת מטלות שאני צריך לעשות עם ציטוט מתאים עבור כל מטלה ממכתב השחרור
  הרשימה בפורמט כך שבין כל שני משימות מפריד  &&
     """,
            )
          ],
    )
        .data;
    print("JABETTA:");
    // print(completion);

    // List<String> tasksList = completion.toString().split('\n\n');

    // List<String> formattedTasksList = tasksList.map((task) {
    //   List<String> lines = task.split('\n');
    //   lines.removeWhere((line) => line.isEmpty);
    //   String taskNumber = lines.first.split('.').first;
    //   String taskDescription = lines.first.substring(lines.first.indexOf('.') + 1).trim();
    //   return '$taskNumber. $taskDescription\n${lines.skip(1).join('\n')}';
    // }).toList();

    List<String> lines=completion.choices[0].message.content.split("&&");
    print(lines);
    return lines;
    print(lines);
  }
  void initState() {
    super.initState();
    final conf = OpenAIConfiguration(
        organizationId:  "org-S1zDIfQUIOHMtiVR9PAWp6wR",
        apiKey: "not this time you silly goose"
    );
    client = OpenAIClient(configuration: conf,enableLogging: true);
    chatgpt();

    // Fetch the models.♦
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
        Column(children: [Text(stations[0].name!), Text(stations[0].time!)]));
    int c = 0;
    stations.forEach((station) {
      if (c != 0) {
        texts.add(Container(height: 90));
        texts.add(Column(children: [Text(station.name!), Text(station.time!)]));
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularAppBar(
            "הביקור שלי",
            [
            Positioned(child:Container(
                height: 700,
                width:MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                child: Container(
                child:

    FutureBuilder(
    future: chatgpt(),
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if(snapshot.hasData) {
        _data = parseItems(snapshot.data!);
        return _buildPanel();
      }
      return CircularProgressIndicator();
    },
              ),
            ))),
              top:150
            )
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
      children: [ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
      return ListTile(
        title: Text(_data[0].headerValue),
      );
    },
    body: ListTile(
    title: Text(_data[0].expandedValue),
    subtitle:
    const Text("סיכום למטלה:\n\nטיפול מקומי דורש הקפדה על רגל מורמת ולמרוח משחת פוסידין או סטפידרם ביוס לטיפול בזיהומי עור שכיחים כמו חתכים, עקיצות מזוהמות ואימפטיגו. פוסידין וסטפידרם מכילים אנטיביוטיקה שכיחה לטיפול בזיהומי עור וכדאי להתחשב בהבדלים בין הצורות השונות של התכשיר. כדאי להשתמש במשחת פוסידין או סטפידרם לטיפול מקומי לפני שהגישה לאנטיביוטיקה דרך הפה."),
    onTap: () {
    setState(() {
    _data.removeWhere((Item currentItem) => item == currentItem);
    });
    }),
    isExpanded: item.isExpanded,
    ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(_data[1].headerValue),
            );
          },
          body: ListTile(
              title: Text(_data[1].expandedValue),
              subtitle:
              const Text("Loading..."),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(_data[2].headerValue),
            );
          },
          body: ListTile(
              title: Text(_data[2].expandedValue),
              subtitle:
              const Text("Loading..."),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(_data[3].headerValue),
            );
          },
          body: ListTile(
              title: Text(_data[3].expandedValue),
              subtitle:
              const Text("Loading..."),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(_data[4].headerValue),
            );
          },
          body: ListTile(
              title: Text(_data[4].expandedValue),
              subtitle:
              const Text("Loading..."),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        ),
      ]
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