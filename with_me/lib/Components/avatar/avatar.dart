import '../../header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
import '';
//
// class Avatar extends StatelessWidget {
//   // This widget is the root of your application.
//   Avatar({required this.first, this.data});
//
//   final bool first;
//   final Future<AvatarData>? data;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: (first)
//           ? AvatarPage(
//               title: "hey",
//               first: first,
//               data: AvatarData(body: AvatarData.body_default, money: 10))
//           : FutureBuilder(
//               future: data,
//               builder:
//                   (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
//                 if (snapshot.hasData) {
//                   return AvatarPage(
//                       title: "hey",
//                       first: first,
//                       data: (snapshot.data ??
//                           AvatarData(
//                               body: AvatarData.body_default,
//                               hands: AvatarData.hand_default,
//                               body_color: AvatarData.color_default)));
//                 } else
//                   return CircularProgressIndicator(
//                     color: Colors.green,
//                   );
//               }),
//     );
//   }
// }

class AvatarPage extends StatefulWidget {
  AvatarPage(
      {Key? key, required this.title})
      : super(key: key){
    // this.data = this.data ?? ;
    this.data = AvatarData.currAvatar ?? this.data;
    if(AvatarData.currAvatar!=null){
      this.isLoaded=true;
    }
  }
  final String title;

  @override
  _AvatarPageState createState() => _AvatarPageState();
  AvatarData data= AvatarData(body: AvatarData.body_default, money: 10);
  bool isLoaded = false;
}

class _AvatarPageState extends State<AvatarPage> {
  buy(int i, int j, int n) {
    int money = widget.data.money ?? 0;
    if ((widget.data.acquired?.acquired_items[i][j][n] ?? false) ||
        money >= AvatarShop.merch[i][j][n].item2) {
      setState(() {
        widget.data.money = (money - AvatarShop.merch[i][j][n].item2) as int?;
        widget.data.acquired?.acquired_items[i][j][n] = true;
      });
    }
  }

  choose(int group, int sub_group, int object) {
    print(object);
    if (widget.data.acquired?.acquired_items[group][sub_group][object] ??
        false) {
      switch (group) {
        case 0:
          {
            if (sub_group == 0)
              setState(() {
                widget.data.glasses =
                    AvatarShop.merch[group][sub_group][object].item1;
              });
          }
          break;
        case 1:
          {
            if (sub_group == 0) {
              if (object == 0)
                setState(() {
                  widget.data.body_color = Color(0xff6f6ca7);
                });
              if (object == 1)
                setState(() {
                  widget.data.body_color = Color(0xffa6d6c3);
                });
              if (object == 2)
                setState(() {
                  widget.data.body_color = Color(0xffdabfa0);
                });
              if (object == 3)
                setState(() {
                  widget.data.body_color = Color(0xffefb3e2);
                });
            } else if (sub_group == 1) {
              if (object == 0)
                setState(() {
                  widget.data.eye_color = Color(0xff6f6ca7);
                });
              if (object == 1)
                setState(() {
                  widget.data.eye_color = Color(0xffa6d6c3);
                });
              if (object == 2)
                setState(() {
                  widget.data.eye_color = Color(0xffdabfa0);
                });
              if (object == 3)
                setState(() {
                  widget.data.eye_color = Color(0xffefb3e2);
                });
            }
          }
          break;
        case 2:
          {
            setState(() {
              widget.data.pants =
                  AvatarShop.merch[group][sub_group][object].item1;
            });
          }
          break;
      }
    }
  }

  Widget build_money(String text) {
    return Stack(children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: Colors.white,
        ),
      ),
      Container(
        width: 24,
        height: 26,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 0.65,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget build_money_alert(int new_cash) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            width: _width * 0.8,
            height: _height * 0.7,
            decoration: BoxDecoration(
              // color: Colors.green,

              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xff35258a),
                width: 3,
              ),
              color: Color(0xfff4f4f4),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Container(
                    child: FittedBox(
                      child: Image.asset('images/shibi_pages/money.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0.5 * 0.65 * MediaQuery.of(context).size.height,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "יאייייי!",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            " זכית ב-" + "5 " + " מטבעות",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "השתמשו בהם בחוכמה ;]",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.assistant(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ]))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {



    // if (widget.first) {
    //   widget.first = false;
    //   Future.delayed(Duration(milliseconds: 500), () {
    //     showDialog<String>(
    //         context: context,
    //         builder: (BuildContext context) => build_money_alert(10));
    //   });
    // }
    return Scaffold(
      body: FutureBuilder<AvatarData?>(
        future: Future(()async{
          if (!widget.isLoaded){
            widget.isLoaded=true;
            AvatarData? loadedAvatar = await DB.getAvatar(context.read<FirebaseAuthMethods>().user.uid);
            AvatarData.currAvatar = loadedAvatar ?? AvatarData.currAvatar;
            widget.data=loadedAvatar ?? widget.data;
          }

        }),
        builder: (context,snapshot){
            return build_screen(context);

        },
      ),
    );
  }

  Widget build_screen(BuildContext context){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _min = min(_width, _height);
    return Stack(children: [

      Positioned(
          left: -0.8 * MediaQuery.of(context).size.width,
          top: -1.25 * MediaQuery.of(context).size.height,
          child: Container(
              width: 0.8125 * MediaQuery.of(context).size.height * 2,
              height: 0.8125 * MediaQuery.of(context).size.height * 1.8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.data.body_color?.withOpacity(0.7)))),
      Positioned(
          right: 25,
          top: 75,
          child: Align(
              alignment: Alignment.topRight,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "עיצוב השיבי שלך",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.assistant(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ]))),

      // Figma Flutter Generator Group304Widget - GROUP

      Positioned(
          left: 22,
          top: 131.32,
          child: build_money(widget.data.money.toString())),
      Positioned(
          right: MediaQuery.of(context).size.width * 0.08,
          top: MediaQuery.of(context).size.height * 0.19,
          child: Stack(
            children: [
              Container(
                width: 192,
                height: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(88),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Color(0xffc4c4c4),
                ),
              ),
              Container(
                width: 96,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(88),
                  color: Color(0xff35258a),
                ),
              ),
              Positioned(
                  child: Text('חנות',
                      style: GoogleFonts.assistant(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  left: 30,
                  top: 6),
              Positioned(
                  child: Text('המוצרים שלי',
                      style: GoogleFonts.assistant(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  left: 105,
                  top: 6)
            ],
          )),
      Positioned(
        left: 45,
        top: 120,
        child: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
        ),
      ),

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(height: 200),
            Flexible(
              flex: 1,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: AvatarStack(
                    data: widget.data,
                  )),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff35258a),
                    shape: CircleBorder(),
                    fixedSize: Size(55, 55),
                  ),
                  child: Icon(
                    Icons.save,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    DB.insertAvatar(widget.data,
                        context.read<FirebaseAuthMethods>().user.uid);
                    AvatarData.currAvatar = widget.data;
                  },
                )
              ],
            ),
            /* Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff35258a),
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _save();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
                      },
                    ),
                  ],
                ),*/
            AvatarBar(
                shop: widget.data.acquired ??
                    AvatarShop(AvatarShop.empty().toString()),
                tap: choose,
                dtap: buy),
          ],
        ),
      ),
      Positioned(
        right: 0.05 * MediaQuery.of(context).size.width,
        top: 0.05 * MediaQuery.of(context).size.height,
        child:
        GestureDetector(
          child: const Icon(Icons.logout),
          onTap: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
        ),),
    ]);
  }
}

class AvatarStack extends StatelessWidget {
  AvatarStack(
      {required this.data, this.isBack = false, this.isNude = false, Key? key})
      : super(key: key);

  final bool isNude, isBack;
  Map<String, Tuple3<double, double, double>> dits = {
    // image :            top offset , left offset, height
    'images/handsclosed.png': Tuple3(
      0.3,
      0,
      0.25,
    ),
    'images/handsopen.png': Tuple3(
      0.2,
      0,
      0.3,
    ),
    'images/handsdown.png': Tuple3(
      0.4,
      0.02,
      0.3,
    ),
    'images/handsbaloon.png': Tuple3(
      0,
      0,
      0.9,
    ),

    'images/skirt.png': Tuple3(
      0.58,
      0,
      0.15,
    ),
    'images/skirt2.png': Tuple3(
      0.6,
      0,
      0.15,
    ),
    'images/bluepants.png': Tuple3(
      0.6,
      0,
      0.17,
    ),
    'images/armypants.png': Tuple3(
      0.6,
      0,
      0.23,
    ),
    'images/pinkpants.png': Tuple3(
      0.58,
      0,
      0.15,
    ),
  };
  final AvatarData data;

  @override
  Widget build(BuildContext context) {
    return Center(child:
        LayoutBuilder(builder: (BuildContext context, BoxConstraints cons) {
      return Container(
          // color:Colors.grey,
          width: min(cons.maxWidth, cons.maxHeight),
          height: min(cons.maxWidth, cons.maxHeight),
          child: Stack(children: <Widget>[
            //legs
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.green,
                        child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: ImageColorSwitcher(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * 0.35,
                              color: data.body_color!,
                              imagePath: data.legs!,
                              second: Color(0xffAC957B),
                              main: Color(0xffDABFA0),
                            )),
                        height: constraints.maxHeight * 0.35,
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.6,
                          // left: constraints.maxWidth/14
                        ),
                      ),
                    ]);
              },
            ),
            //pants
            if (!isNude && data.pants != null)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (dits[data.pants!] == null) return Container();
                  Tuple3<double, double, double> dit = dits[data.pants!]!;
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: constraints.maxHeight * dit.item3,
                          width: constraints.maxWidth,
                          // color: Colors.green,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Image.asset(data.pants!)),
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * dit.item1,
                            left: constraints.maxWidth * dit.item2,
                            // left: constraints.maxWidth/14
                          ),
                        ),
                      ]);
                },
              ),
            //body
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var r = constraints.maxWidth * 0.5;
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Container(
                              width: r,
                              height: r,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(r),
                                  border: Border.all(
                                    color: data.body_color ?? Colors.grey,
                                    width: r * 45 / 128,
                                  ))),
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.15,
                          )),
                    ]);
              },
            ),
            //ass
            if (isBack && isNude)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  print('ass');
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.green,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: ImageColorSwitcher(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight * 0.04,
                                color: data.body_color!,
                                imagePath: 'images/ass.png',
                                second: Color(0xffAC957B),
                                main: Color(0xffDABFA0),
                              )),
                          height: constraints.maxHeight * 0.04,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.56,
                            // left: constraints.maxWidth * dit.item2,
                            // left: constraints.maxWidth/14
                          ),
                        ),
                      ]);
                },
              ),
            //hands
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (dits[data.hands!] == null) return Container();
                Tuple3<double, double, double> dit = dits[data.hands!]!;
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.green,
                        child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: ImageColorSwitcher(
                              width: constraints.maxWidth * (1 - dit.item2),
                              height: constraints.maxHeight * dit.item3,
                              color: data.body_color!,
                              imagePath: data.hands!,
                              second: Color(0xffAC957B),
                              main: Color(0xffDABFA0),
                              forgive: (isBack) ? 80 : 40,
                            )),
                        height: constraints.maxHeight * dit.item3,
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * dit.item1,
                          left: constraints.maxWidth * dit.item2,
                          // left: constraints.maxWidth/14
                        ),
                      ),
                    ]);
              },
            ),
            //eyes
            if (!isBack)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ImageColorSwitcher(
                            color: data.eye_color!,
                            height: constraints.maxHeight * 0.08,
                            width: constraints.maxWidth,
                            main: Color(0xff000000),
                            second: Color(0xff000000),
                            imagePath: data.glasses!,
                            forgive: 100,
                          ),
                          height: constraints.maxHeight * 0.08,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.18,
                            // left: constraints.maxWidth/14
                          ),
                        ),
                      ]);
                },
              )
          ]));
    }));
  }
}
//
// class LoadAvatar extends StatefulWidget {
//   @override
//   _LoadAvatarState createState() => _LoadAvatarState();
// }
//
// class _LoadAvatarState extends State<LoadAvatar> {
//   Future<AvatarData>? _data;
//
//   @override
//   void initState() {
//     super.initState();
//     _data = DB.getAvatar(context.read<FirebaseAuthMethods>().user.uid);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _data,
//         builder: (BuildContext context, AsyncSnapshot<AvatarData> snapshot) {
//           if (snapshot.hasData) {
//             return AvatarStack(
//                 data: (snapshot.data ??
//                     AvatarData(
//                       body: AvatarData.body_default,
//                       hands: AvatarData.hand_default,
//                     )));
//           } else
//             return CircularProgressIndicator(
//               color: Colors.green,
//             );
//         });
//   }
// }
