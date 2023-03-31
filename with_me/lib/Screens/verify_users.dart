
import 'package:with_me/Components/type_list.dart';

import '../header.dart';

class VerifyUsersPage extends StatefulWidget {
  const VerifyUsersPage({super.key});
  @override
  State<VerifyUsersPage> createState() => _VerifyUsersPageState();
}

class _VerifyUsersPageState extends State<VerifyUsersPage> {
  List<List> choices = [['מנהל',Permissions.manager],['טלפן',Permissions.caller],['מתנדב',Permissions.volunteer], ['הסר',-1]];

  Map<String,int> currentChoices = {};

  Widget users_list_builder(context, snapshot){
    final List users=snapshot.data!.docs;
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var current=users[index];
          if(!currentChoices.containsKey(current.id)){
            currentChoices[current.id] = -1;
          }
          return Dismissible(
              key: Key(current['name']),
              onDismissed: (direction){
                DB.setUserPermissions(Client.fromMap(current.data(), current.id), -2);
              },
              background: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("הסר בהחלקה", style: GoogleFonts.assistant(
                color: Colors.red[200],
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none
                ),),
              ),
              child: Center(child:ListTile(
                leading: Button(
                  () {DB.setUserPermissions(Client.fromMap(current.data(), current.id), 0);},
                  'אשר'
              ),
                // DropdownButton<int>(
                //   value:  currentChoices[current.id]!,
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   onChanged: (int? value) {
                //     // This is called when the user selects an item.
                //
                //     setState(() {
                //       currentChoices[current.id]=value!;
                //     });
                //   },
                //   items: choices.map<DropdownMenuItem<int>>((List value) {
                //     return DropdownMenuItem<int>(
                //       value: value[1],
                //       child: Text(value[0]),
                //     );
                //   }).toList(),
                // ),

                title:Text(current['name'], textDirection: TextDirection.rtl),
              ))
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: StyledAppBar(context, 'אישור מטופלים חדשים',
      //   actions: [
      //     GestureDetector(
      //       child: const Icon(Icons.logout),
      //       onTap: () {
      //         context.read<FirebaseAuthMethods>().signOut(context);
      //       },
      //     ),
      //   ],
      // ),
      body: CircularAppBar(
          "אישור מטופלים חדשים", [
            Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(height: 150),
            Expanded(child: StreamBuilder<QuerySnapshot>(
                stream: DB.getUsersByPermissions(-1),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return users_list_builder(context, snapshot);
                  }
                  return const Center(child: CircularProgressIndicator());
                }
            ))
          ],
        ),
      )],
          context,
          back_arrow: GestureDetector(
        child: const Icon(Icons.logout),
        onTap: () {
          context.read<FirebaseAuthMethods>().signOut(context);
        },
      ))
      ,
    );
  }
}
