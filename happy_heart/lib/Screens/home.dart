import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pages _currentPage = Pages.supply;

  void changePageCallback(int index) {
    setState(() {
      _currentPage = Pages.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    var perm_ = Permissions.getFirstUserPermissions(context);
    return FutureBuilder<int>(
        future: perm_,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int perm = snapshot.data as int;
            print('user permissions are $perm');
            if(perm<0){
              return Center(child: Column(children: const [
                CircularProgressIndicator(),
                Center(child: Text('חכה לאישור ממנהל ותפתח מחדש', textDirection: TextDirection.rtl,),)
              ],));
            }
            return Scaffold(
              bottomNavigationBar:
                  bottomNavigation(_currentPage, changePageCallback),
              body: getPage(_currentPage),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
     );
  }
}
