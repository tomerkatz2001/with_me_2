
import 'package:with_me/Screens/discharge_notes.dart';
import 'package:with_me/Screens/search.dart';
import 'package:with_me/Screens/supply_page.dart';
import 'package:with_me/Screens/visit_course.dart';
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
      return const VisitCoursePage();
    case Pages.search:
      return const SearchPage();
    case Pages.verify:
      return const  DischargePage();
    case Pages.listOfVolunteers:
      return const ManageVolunteers();
  }
}

/* Also add the Icon and name in case you want to add more pages*/
BottomNavigationBar bottomNavigation(Pages page, void Function(int) OnClickCallback){
  // return BottomNavigationBar(
  //   items: const <BottomNavigationBarItem>[
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.accessibility),
  //       label: 'הביקור שלי',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.search),
  //       label: 'חיפוש',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.admin_panel_settings_outlined),
  //       label: 'אישור משתמשים',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.people),
  //       label: 'רשימת מטופלים',
  //     ),
  //   ],
  //   currentIndex: page.index,
  //   selectedItemColor: Colors.amber[600],
  //   unselectedItemColor: Colors.grey,
  //   showUnselectedLabels: true,
  //   onTap: OnClickCallback ,
  // );

  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black,
      unselectedLabelStyle: GoogleFonts.assistant(
          color:Colors.black,
          fontWeight:FontWeight.w900
      ),
      selectedLabelStyle: GoogleFonts.assistant(
          color:Colors.black,
          fontWeight:FontWeight.w900
      ),
      backgroundColor: Color(0xffCBC3E3),
      currentIndex: page.index,
      onTap: OnClickCallback,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (page.index != 0)
                  ? Color(0xff9e7fe0)
                  : Color(0xff35258a),
            ),
            child: Icon(Icons.map,color: Colors.white),
          ),
          label: 'הביקור שלי',

        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (page.index != 1)
                  ? Color(0xff9e7fe0)
                  : Color(0xff35258a),
            ),
            child: Icon(Icons.accessibility,color: Colors.white),
          ),
          label: 'יומן',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (page.index != 2)
                  ? Color(0xff9e7fe0)
                  : Color(0xff35258a),
            ),
            child: Icon(Icons.accessibility,color: Colors.white),
          ),
          label: 'פסיכוחינוך',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (page.index != 3)
                  ? Color(0xff9e7fe0)
                  : Color(0xff35258a),
            ),
            child: Icon(Icons.accessibility,color: Colors.white),
          ),
          label: 'תרגילים',
        ),
      ]);
}