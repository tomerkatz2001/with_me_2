import 'package:happy_heart/header.dart';

ListTile typeListTile(String name, {int? itemsCount, GestureTapCallback? onTap, bool showAccess =true}) {
  return ListTile(
      leading:
          //TODO: add option to make an item taken
          showAccess?GestureDetector(
        child: const Icon(
          Icons.arrow_back_ios,
          size: 24.0,
        ),
        onTap: () {},
      ):Container(
            width: 24.0,
            height: 24.0,
          ),
      title: Text(name, textDirection: TextDirection.rtl),
      subtitle: Text((itemsCount==null)? '':itemsCount.toString(), textDirection: TextDirection.rtl),
      onTap: onTap);
}
