import 'package:happy_heart/Screens/search.dart';
import 'package:happy_heart/Screens/supply_page.dart';
import 'package:happy_heart/header.dart';

enum Pages{
 supply,
 search,
}
Widget getPage(Pages page){
  switch(page){
    case Pages.supply:
      return const SupplyPage();
    case Pages.search:
      return const SearchPage();
  }

}
BottomNavigationBar bottomNavigation(Pages page, void Function(int) OnClickCallback){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.healing),
        label: 'ציוד',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'חיפוש',
      ),
    ],
    currentIndex: page.index,
    selectedItemColor: Colors.amber[800],
    onTap: OnClickCallback ,
  );
}