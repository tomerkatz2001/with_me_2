import 'package:happy_heart/header.dart';

class DeliveriesPage extends StatelessWidget {
  const DeliveriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: DeliverySubPages.values.length,
      initialIndex: DeliverySubPages.values.length - 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('שינועים'),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: 'הסתיימו'),
              Tab(text: 'בשינוע'),
              Tab(text: "בקשות שינוע"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DeliverySubPage(DeliverySubPages.delivered, null),
            DeliverySubPage(DeliverySubPages.onDeliver, null),
            DeliverySubPage(DeliverySubPages.toBeDelivered, null),
          ],
        ),
        floatingActionButton: FloatingButton((){
          Navigator.of(context).pushNamed("/add_delivery");
        })  ,
      ),
    );
  }
}
