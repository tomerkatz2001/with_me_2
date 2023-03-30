
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
                DB.setUserPermissions(current.id, currentChoices[current.id]!);
              },
              child: Center(child:ListTile(
                leading: DropdownButton<int>(
                  value:  currentChoices[current.id]!,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (int? value) {
                    // This is called when the user selects an item.

                    setState(() {
                      currentChoices[current.id]=value!;
                    });
                  },
                  items: choices.map<DropdownMenuItem<int>>((List value) {
                    return DropdownMenuItem<int>(
                      value: value[1],
                      child: Text(value[0]),
                    );
                  }).toList(),
                ),
                // Button(
                //   () {},
                //   'בצע'
                // )
                title:Text(current['name'], textDirection: TextDirection.rtl),
              ))
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: StyledAppBar(context, 'לב חדווה',
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            VerticalSpacer(50),
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
      ),
    );
  }
}
