
import '../header.dart';

AppBar StyledAppBar(BuildContext context , String title,{Widget leading= const SizedBox(),List<Widget> actions=const []}){
  return AppBar(
    title: Text(title),
    leading: leading,
    actions: actions,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

class _LoadBar extends CustomPainter {
  final double percent;
  final Size size;
  final Color color;

  _LoadBar({
    required this.percent,
    required this.size,
    required this.color
  });
  @override
  void paint(Canvas canvas, Size size) {
    var painter = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    Offset center = Offset(size.width / 2, -size.width * 0.3);
    canvas.drawCircle(
        center,
        size.width * 1.05,
        painter
          ..color = color
          ..style = PaintingStyle.fill);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width * 1.05),
        0,
        pi,
        false,
        painter
          ..color = Color(0xffc4c4c4)
          ..style = PaintingStyle.stroke);
    double pad = 0.2;

    Offset off1 = center +
        Offset(-sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Offset off2 = center + //
        Offset(sin(pi / 6 - pad) * size.width, cos(pi / 6 - pad) * size.width);
    painter
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
  }

  @override
  bool shouldRepaint(_LoadBar oldDelegate) {
    return percent != oldDelegate.percent;
  }
}


Widget CircularAppBar( String title,List<Widget> childs,BuildContext context,{double offset=0,Color color=const Color(0xffdee8f3), Widget? back_arrow=null} ){
  childs.add(Align(alignment: Alignment.topCenter,child:Padding(padding: EdgeInsets.only(top: 50),
      child:Text(title,style: Theme.of(context).textTheme.titleLarge))));
  childs.add(Positioned(
      top: (-150)-offset,
      child: Container(
        child:
        TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 0.7),
            duration: Duration(seconds: 1),
            builder:
                (BuildContext context, double percent, Widget? child) {
              return CustomPaint(
                  painter: _LoadBar(percent: 0, size: MediaQuery.of(context).size,color:color),
                  size: MediaQuery.of(context).size);
            }),
        // color:Colors.green
      )));

  if(back_arrow==null) {
    childs.add(Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 50,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_forward),
            ),
            Container(
              height: 10,
            ),
          ],
        ),
        margin: EdgeInsets.all(30),
      ),
    ));
  }
  else{
    childs.add(Align(alignment: Alignment.topRight,
      child: back_arrow,));
  }

  return Stack(children: childs.reversed.toList());

}