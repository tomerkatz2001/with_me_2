import '../header.dart';

AppBar StyledAppBar(BuildContext context , String title,{Widget leading= const SizedBox(),List<Widget> actions=const []}){
  return AppBar(
    title: Text(title),
    leading: leading,
    actions: actions,
    elevation: 0,
  );
}