import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pages _currentPage = Pages.supply;

  Widget typeListBuilder(context, snapshot) {
    if (snapshot.hasData) {
      List types = snapshot.data!.docs;
      types.removeWhere((element) {
        return element.data()["name"] == null;
      });

      return ListView.builder(
          itemCount: types.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var current = types[index];
            return Center(
                child: ListTile(
                    leading: GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 24.0,
                      ),
                      onTap: () {},
                    ),
                    title: Text(current.data()["name"],
                        textDirection: TextDirection.rtl),
                    onTap: () => {
                          Navigator.of(context).pushNamed('/equipment_type',
                              arguments: EquipmentTypeArguments(
                                  current.data()["name"]))
                        }));
          });
    }
    return const Center(child: CircularProgressIndicator());
  }

  final Stream typesStream = DB.getTypesStream();

  late StreamBuilder typeListStreamBuilder;

  @override
  void initState() {
    super.initState();
    typeListStreamBuilder =
        StreamBuilder(stream: typesStream, builder: typeListBuilder);
  }
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
                Text(
                  '\n\n\nאנו מודים לכם על הצטרפותכם למשפחת לב חדווה! \nאנא המתינו לאישור מהמנהל ולאחר מכן פתחו מחדש את האפליקציה.\n\n',
                  textDirection: TextDirection.rtl, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber, 
                    fontSize: 20,
                  ),
                ),
                Text(
                  'קצת עלינו:\n',
                  textDirection: TextDirection.rtl, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber, 
                    fontSize: 20,
                  ),
                ),
                Text(
                  'עמותת לב חדווה הוקמה בשנת 2021 על ידי אליהו אליוביץ \n מטרתה העיקרית היא סיוע באספקת תרופות וציוד רפואי לציבור.',
                  textDirection: TextDirection.rtl, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber, 
                    fontSize: 20,
                  ),
                )
                
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
