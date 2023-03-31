import '../header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pages _currentPage = Pages.dayTasks;
  bool firstPage= true;

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
      int start = (Permissions.manager==Permissions.getUserPermissions())? 3:0;
      _currentPage = Pages.values[start+index];
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<int> perm_ = Permissions.getFirstUserPermissions(context);
    return FutureBuilder<int>(future: Future(() async {
      AvatarData.currAvatar =
          (await DB.getAvatar(context.read<FirebaseAuthMethods>().user.uid)) ??
              AvatarData(body: AvatarData.body_default, money: 10);
      return perm_;
    }), builder: (context, snapshot) {
      if (snapshot.hasData) {
        int perm = snapshot.data as int;
        if(firstPage){
          firstPage=false;
          _currentPage =
          (Permissions.volunteer == Permissions.getUserPermissions())
              ? Pages.dayTasks
              : Pages.listOfPatients;
        }

        print('user permissions are $perm');
        if (perm < 0) {
          return Center(
            child: Container(

              color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'איזה כיף שהצטרפת למשפחת איתי!\n\nתכף תינתן הגישה לאפליקציה אנא המתן שהסגל הרפואי יאשר את הרשמתך.\n תוכל לצאת מהאפליקציה ולהיכנס לאחר שהצוות יאשר זאת.',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.assistant(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.none
                                        ),

                      ),
                      Container(height: 50,),
                      Image.asset('assets/2.png')
                    ],
                  ),
            )),
          );
        }
        return Scaffold(
          bottomNavigationBar:
              bottomNavigation(_currentPage, changePageCallback),
          body: getPage(_currentPage),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
