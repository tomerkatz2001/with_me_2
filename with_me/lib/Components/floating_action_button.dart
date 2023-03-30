import 'package:with_me/header.dart';
Widget FloatingButton(onPressed){
  return FloatingActionButton(
    onPressed:onPressed,
    backgroundColor: Colors.amber,
    child: const Icon(Icons.add),
  );
}