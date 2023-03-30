import 'package:with_me/Screens/search.dart';
import 'package:with_me/Screens/supply_page.dart';
import 'package:with_me/header.dart';

/*The order of the pages in this enum determines the order in the bottom_navigation
* If you want to add more pages add the name of the page here and also add a case in
* the getPage function below.*/
enum Pages{
  supply,
  search,
  verify,
  listOfVolunteers,
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
    case Pages.listOfVolunteers:
      return const ManageVolunteers();
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
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'רשימת מטופלים',
      ),
    ],
    currentIndex: page.index,
    selectedItemColor: Colors.amber[600],
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    onTap: OnClickCallback ,
  );
}