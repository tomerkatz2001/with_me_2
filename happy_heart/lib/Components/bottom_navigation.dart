import 'package:happy_heart/Screens/search.dart';
import 'package:happy_heart/Screens/supply_page.dart';
import 'package:happy_heart/header.dart';

/*The order of the pages in this enum determines the order in the bottom_navigation
* If you want to add more pages add the name of the page here and also add a case in
* the getPage function below.*/
enum Pages{
  supply,
  search,
  verify,
  listOfVolunteers,
  deliveries
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
    case Pages.deliveries:
      return const DeliveriesPage();
  }
}
Widget getPageUser(Pages page){
  switch(page){
    case Pages.supply:
      return const DeliveryMap();
    case Pages.search:
      return MyDeliveriesPage();
  }
  return const DeliveryMap();
}

/* Also add the Icon and name in case you want to add more pages*/
BottomNavigationBar bottomNavigation(Pages page, void Function(int) OnClickCallback, bool isManager ){
  return BottomNavigationBar(
    items: isManager? const <BottomNavigationBarItem>[
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
        label: 'רשימת מתנדבים',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_shipping),
        label: 'שינועים',
      ),
    ] :const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
      icon: Icon(Icons.local_shipping),
      label: 'שינועים',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.run_circle_outlined),
        label: 'שינועים שלי',
      ),
    ] ,
    currentIndex: page.index,
    selectedItemColor: Colors.amber[600],
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    onTap: OnClickCallback ,
  );
}