import 'package:happy_heart/header.dart';


class DeliverySubPage extends StatelessWidget {
  DeliverySubPages subPagesType;

  DeliverySubPage(this.subPagesType, Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DB.getDeliveriesSteam(filter: subPagesType.name),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            List<Delivery> deliveries = snapshot.data!.docs.map((e) => e.data()).toList();
            if(deliveries.isEmpty){
              String image="";
              String text="";
              switch(subPagesType) {
                case DeliverySubPages.toBeDelivered:
                  image = "assets/Relaxing.png";
                  text = "אין בקשות לשינועים כעת";
                  break;
                case DeliverySubPages.onDeliver:
                  image = "assets/delivery_address.png";
                  text = "אין שינועים כעת";
                  break;
                case DeliverySubPages.delivered:
                  image = "assets/humanitarian_help_2.png";
                  text = "לא נמצאו שינועים שנגמרו בפרק זמן המבוקש";
              }
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
                return DeliveryListTile(deliveries[index]);
              },
            );
          }
          else if(snapshot.hasError){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
