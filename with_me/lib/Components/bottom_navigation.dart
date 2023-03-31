
import 'package:with_me/Screens/avatar_chatbot.dart';
import 'package:with_me/Screens/discharge_notes.dart';
import 'package:with_me/Screens/search.dart';
import 'package:with_me/Screens/supply_page.dart';
import 'package:with_me/Screens/visit_course.dart';
import 'package:with_me/header.dart';


/*The order of the pages in this enum determines the order in the bottom_navigation
* If you want to add more pages add the name of the page here and also add a case in
* the getPage function below.*/
enum Pages{
  dayTasks,
  avatar,
  gpt,
  verify,
  listOfPatients

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
    case Pages.dayTasks:
      return const VisitCoursePage();
    case Pages.avatar:
      return AvatarPage(title: 'כככ', );
    case Pages.verify:
      return const VerifyUsersPage();
    case Pages.listOfPatients:
      return const ManageVolunteers();
    case Pages.gpt:
      return const ChatbotPage();


  }
}

/* Also add the Icon and name in case you want to add more pages*/
BottomNavigationBar bottomNavigation(Pages page, void Function(int) OnClickCallback){
  List<BottomNavigationBarItem> icons = [];
  if (Permissions.volunteer==Permissions.getUserPermissions()){
    icons=[
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
        label: 'אווטאר',
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
          child: Icon(Icons.star,color: Colors.white),
        ),
        label: 'AI',
      ),
    ];
  }else{
    icons=[
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
          child: Icon(Icons.shield_outlined,color: Colors.white),
        ),
        label: 'אישור',
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
          child: Icon(Icons.timelapse,color: Colors.white),
        ),
        label: 'נהל יום',
      ),
    ];
  }
  int start = (Permissions.manager==Permissions.getUserPermissions())? 3:0;
  print('page${page.index} , start${start}');

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
      currentIndex: page.index-start,
      onTap: OnClickCallback,
      items: icons );
}