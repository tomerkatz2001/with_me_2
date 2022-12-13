import 'package:happy_heart/Screens/search.dart';
import 'package:happy_heart/Screens/supply_page.dart';
import 'package:happy_heart/header.dart';

/*The order of the pages in this enum determines the order in the bottom_navigation
* If you want to add more pages add the name of the page here and also add a case in
* the getPage function below.*/
enum Pages{
  supply,
  search,
  verify
}

/*Add more case if you want to add a new page to the bottom_navigation
* Use this template:
* '''
* case Pages<pageName>:
*   return <PageWidget>;
* '''
* */
Widget getPage(Pages page){
  switch(page){
    case Pages.supply:
      return const SupplyPage();
    case Pages.search:
      return const SearchPage();
    case Pages.verify:
      return const VerifyUsersPage();
  }
}

/* Also add the Icon and name in case you want to add more pages*/
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
      BottomNavigationBarItem(
        icon: Icon(Icons.admin_panel_settings_outlined),
        label: 'אישור משתמשים',
      ),

    ],
    currentIndex: page.index,
    selectedItemColor: Colors.amber[800],
    onTap: OnClickCallback ,
  );
}