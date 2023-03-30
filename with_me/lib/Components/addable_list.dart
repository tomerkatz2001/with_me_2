import 'package:with_me/header.dart';

class AddableList extends StatefulWidget {
  var items;
  AddableList(_items){
    items=_items;
  }
  @override
  AddableListState createState() => AddableListState(items);
}

class AddableListState extends State<AddableList> {
  var _items;
  AddableListState(items){
    _items=items;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
    final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}