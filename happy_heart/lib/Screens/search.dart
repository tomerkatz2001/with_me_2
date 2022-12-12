import 'package:happy_heart/header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  final String title = 'search page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text(widget.title),
      ),
      //body:,
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