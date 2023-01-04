// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
              return Center(
                child: Column(children: [
                CircularProgressIndicator(),
                VerticalSpacer(10),
                Center(child:Image.asset('assets/lev-hedva.png')),
                VerticalSpacer(50),
                RichText(
                  text: TextSpan(
                    text: 'אנו מודים לכם על הצטרפותכם למשפחת לב חדווה!\n\n',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                    children: [
                      TextSpan(
                        text: 'אנא המתינו לאישור מהמנהל ולאחר מכן פתחו מחדש את האפליקציה.',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ]
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                VerticalSpacer(80),
                RichText(
                  text: TextSpan(
                    text: 'קצת עלינו:\n',
                    children: [
                      TextSpan(
                        text: 'עמותת לב חדווה הוקמה בשנת 2021 על ידי אליהו אליוביץ בעיצומו של משבר הקורונה ומאז ועד היום, העמותה מספקת ציוד רפואי החל מפלסטרים ובדיקות קורונה ועד מחוללי חמצן.\n',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      TextSpan(
                        text: 'נכון להיום, מספר מתנדבי העמותה מונה מאות של אנשים מכל רחבי הארץ, אשר עוזרים לנו לספק את הציוד הרפואי הנדרש לאנשים באופן מיטבי ומהיר ככל הניתן ובכך מאפשרים לנו לעזור לכל מי שזקוק לנו. \n',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],));
            }
            if(perm==Permissions.volunteer){
              return Scaffold(
                  bottomNavigationBar:
                bottomNavigation(_currentPage, changePageCallback,false),
                body: getPageUser(_currentPage),
              );
            }
            return Scaffold(
              bottomNavigationBar:
                  bottomNavigation(_currentPage, changePageCallback,true),
              body: getPage(_currentPage),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
     );
  }
}
