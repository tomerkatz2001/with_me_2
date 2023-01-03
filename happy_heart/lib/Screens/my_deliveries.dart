import 'package:happy_heart/Components/delivery_dialog.dart';
import 'package:happy_heart/header.dart';


class MyDeliveriesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          context,
          "לב חדווה",
          actions: [
            GestureDetector(
              child: const Icon(Icons.logout),
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
            ),
          ],
        ),
        body:
         StreamBuilder(
        stream: DB.getDeliveriesSteam(filter: "onDelivery"),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            List<Delivery> deliveries = snapshot.data!.docs.map((e) => e.data()).toList();
            deliveries.removeWhere((element) => element.ownerId!=context.read<FirebaseAuthMethods>().user.uid);
            if(deliveries.isEmpty){
                  String image = "assets/delivery_address.png";
                  String text = "אין שינועים כעת";
              return Column(
                children: [
                  Expanded(child: Image(image: AssetImage(image),fit: BoxFit.contain)),
                  Text(text)
                ],
              );
            }
            return ListView.builder(
              itemCount: deliveries.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(child:DeliveryListTile(deliveries[index]), onTap: (){
                  showDeliveryDialog(context, deliveries[index], (){DB.setDeliveryFinished(deliveries[index],context.read<FirebaseAuthMethods>().user.uid);}, "סיום שינוע");});
              },
            );
          }
          else if(snapshot.hasError){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
