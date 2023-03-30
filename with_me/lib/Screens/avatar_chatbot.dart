import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';
import 'package:with_me/header.dart';

import '../Components/appbar.dart';
import '../Components/input.dart';
import '../Objects/station.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  @override
  late OpenAIClient client;

  Future<String> gptGetResponse(String message) async {
    print("SAAAAAAAAAAAAAAAAAAAAAAA");
    final completion = await client.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        ChatMessage(
          role: 'user',
          content: message,
        )
      ],
    ).data;
    print("JABETTA:");
    print(completion);
    // print(completion);

    // List<String> tasksList = completion.toString().split('\n\n');

    // List<String> formattedTasksList = tasksList.map((task) {
    //   List<String> lines = task.split('\n');
    //   lines.removeWhere((line) => line.isEmpty);
    //   String taskNumber = lines.first.split('.').first;
    //   String taskDescription = lines.first.substring(lines.first.indexOf('.') + 1).trim();
    //   return '$taskNumber. $taskDescription\n${lines.skip(1).join('\n')}';
    // }).toList();
    return completion.choices[0].message.content;
  }

  void initState() {
    super.initState();
    final conf = OpenAIConfiguration(
        organizationId: "org-vyZNcstcBoWSWWe9pOLvCzWC",
        apiKey: "not this time you silly goose");
    client = OpenAIClient(configuration: conf, enableLogging: true);
    // Fetch the models.
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
              Positioned(
                      child: SingleChildScrollView(
                          child: Container(
                        child: FutureBuilder(
                          future: gptGetResponse(message),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              if (message == "") {
                                return Text("שלום, אני איתי, בוא ונדבר D:");
                              } else {
                                return Text(snapshot.data as String);
                              }
                            }
                            return Text("...");
                          },
                        ),
                      )),
                  top: 150,
                  left: 50
              ),
              Positioned(
                  child: Column(
                    children: [
                      Row(children: [
                        Input(inputMessageController, "input your message"),
                        Button(() {
                          setState(() {
                            message = inputMessageController.text;
                          });
                        }, "שלח")
                      ]),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: AvatarStack(
                              data: (AvatarData.currAvatar ??
                                  AvatarData(body: AvatarData.body_default))
                                ..hands = 'images/handsdown.png')),
                    ],
                  ),
                  bottom: 50,
                  right: 10),
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
