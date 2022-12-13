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
    return Scaffold(
      appBar: StyledAppBar(context, "לב חדווה",
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout, color: Colors.white),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(child:Image.asset('assets/lev-hedva.png')),
            // TODO: remove this button!
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageVolunteers()),
                );
              },
              child: Text('Volunteers'),
            ),
            VerticalSpacer(50),
            const Text('הציוד שנמצא כרגע במלאי:' , textDirection: TextDirection.rtl),
            VerticalSpacer(50),
            Expanded(child: equipmentListStreamBuilder)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_equipment");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
    var perm_ = Permissions.getFirstUserPermissions(context);
    return FutureBuilder<int>(
        future: perm_,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int perm = snapshot.data as int;
            print('user permissions are $perm');
            if(perm<0){
              return Center(child: Column(children: [
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
