
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
      bottomNavigationBar: bottomNavigation(_currentPage, changePageCallback),
      body: getPage(_currentPage),
    );
  }
}
