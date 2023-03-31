import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';

import '../Components/appbar.dart';
import '../header.dart';
import 'discharge_notes.dart';


class MakeTaskPage extends StatefulWidget {
  static List Lines=[];
  static Patient? patient;

  MakeTaskPage({super.key, }){
    lines = Lines; 
  }
  
  List lines=[];
  @override
  State<MakeTaskPage> createState() => _MakeTaskPageState();
}

class _MakeTaskPageState extends State<MakeTaskPage> {
  late OpenAIClient client;


  Future<String> chatgpt(String text) async {
    // Fetch the models.
    final models = await client.models.list().data;

    // Fetch a model by ID.
    final modelId = await client.models.byId(id: 'text-davinci-002').data;
    final completion = await client.chat.create(
      model: 'gpt-3.5-turbo',
      messages:  [
        ChatMessage(
          role: 'system',
          content: text,
        )
      ],
    ).data;
    print("JABETTA: ${completion.choices[0].message.content}");


    return completion.choices[0].message.content;
  }

  Future<List> makeTasks()async{
    List results = [];
    String reply;
    int amount=0;
    for(String line in widget.lines){
      reply = (await chatgpt('$line \nis this a repeating action? Answer only with yes or no.')).toLowerCase();
      if (!reply.contains('yes')){
        continue;
      }
      reply = (await chatgpt('$line \nhow many times a day this action is repeated? answer with a number and no words, as short as possible.')).toLowerCase();
      if(reply.contains(RegExp(r'(\d+)'))){
        amount = int.parse(RegExp(r'\d+').firstMatch(reply)![0]??'1');
        if(amount==0) continue;
      }
      reply = (await chatgpt('$line \nsummarise the sentence to 5 words, in hebrew.')).toLowerCase();
      results.add([
        reply,line,amount
      ]);
      print([reply,line,amount]);

    }
    return results;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularAppBar(
            "המשימות:",
            [
              Positioned(
                  top: 150,
                  child: Container(
                      height: 700,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: makeTasks(),
                        builder:
                        (context, snapshot){
                          if(snapshot.hasData){
                            return Text(snapshot!.data.toString());
                          }else{
                            return CircularProgressIndicator();
                          }
                        }
                      ))),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(child: Text('שמור'),onPressed: (){
                  Navigator.pop(context);
                },),
              )
            ],
            context));
  }

}


