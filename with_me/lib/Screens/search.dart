import 'package:with_me/header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  final String title = 'לב חדווה';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();
  final ValueNotifier<List> _equipment = ValueNotifier<List>([]);
  List duplicateItems = [];

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(_equipment.value);
    if (query.isNotEmpty) {
      List dummyListData = [];
      dummySearchList.forEach((item) {
        Map dict = getTypesMapFromEquipmentList([item]);
        if (dict.keys.elementAt(0).toString().contains(query)) {
          dummyListData.add(item);
        }
      });
      _equipment.value = dummyListData;
      return;
    } else {
      _equipment.value = duplicateItems; // restore the full list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        context,
        widget.title,
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            StreamBuilder(
              stream: DB.getEquipmentStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _equipment.value = snapshot.data!.docs;
                  duplicateItems = snapshot.data!.docs;
                  return ValueListenableBuilder(
                      valueListenable: _equipment,
                      builder: (BuildContext context, List equipment,
                          Widget? child) {
                        Map dict = getTypesMapFromEquipmentList(equipment);
                        return ListView.builder(
                            itemCount: dict.entries.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var current = dict.keys.elementAt(index);
                              return Center(
                                  child: buildEquipmentRow(
                                      context, current, dict[current].length));
                            });
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

//  Container(
// child: Column(
// children: <Widget>[
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextField(
// onChanged: (value) {
// filterSearchResults(value);
// },
// controller: editingController,
// decoration: const InputDecoration(
// labelText: "Search",
// hintText: "Search",
// prefixIcon: Icon(Icons.search),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.all(Radius.circular(25.0)))),
// ),
// ),
// Expanded(
// child: ListView.builder(
// shrinkWrap: true,
// itemCount: items.length,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text('${items[index]}'),
// );
// },
// ),
// ),
// ],
// ),
// ),
