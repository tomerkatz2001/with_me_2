import 'package:happy_heart/header.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class DeliveryMap extends StatefulWidget {
  const DeliveryMap({super.key});
  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  Location location = new Location();
  late Future<LocationData> locationFuture;
  late Stream<QuerySnapshot<Delivery>> deliveriesStream;
  List<Delivery> deliveries = [];

  Future<void> showDeliveryDialog(context, Delivery delivery) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          Text(delivery.getDescription(),
            textDirection: TextDirection.rtl
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(delivery.getLocationDescription(),
                  textDirection: TextDirection.rtl),
              ],
            ),
          ),
          actions: <Widget>[
            Button(() {
              DB.setDeliveryStarted(delivery);
              Navigator.of(context).pop();
            }, "שנע!"),
          ],
        );
      },
    );
  }

  Widget mapBuilder(
      BuildContext context, AsyncSnapshot<LocationData> location) {
    if (location.hasData &&
        location.data?.latitude != null &&
        location.data?.longitude != null) {
      List<Marker> markers = [];
      for (var delivery in deliveries) {
        markers.add(
            Marker(
                point:
                    LatLng(delivery.dstLocation.lat, delivery.dstLocation.lng),
                builder: (context) => GestureDetector(
                    child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/marker_red.png')),
            onTap: () {
          showDeliveryDialog(context, delivery);
        })));
      }
      markers.add(Marker(
        point: LatLng(location.data?.latitude as double,
            location.data?.longitude as double),
        width: 30,
        height: 30,
        builder: (context) => Container(
            width: 50, height: 50, child: Image.asset('assets/marker.png')),
      ));
      return FlutterMap(
        options: MapOptions(
          center: LatLng(location.data?.latitude as double,
              location.data?.longitude as double),
          zoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget streamBuilder(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Delivery>> deliveriesSnapshot) {
    if (deliveriesSnapshot.hasData) {
      deliveries = [];
      QuerySnapshot<Delivery>? data = deliveriesSnapshot.data;
      if (data != null) {
        for (var delivery in data.docs) {
          deliveries.add(delivery.data());
        }
      }
      return FutureBuilder(future: locationFuture, builder: mapBuilder);
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    deliveriesStream = DB.getDeliveriesSteam();
    locationFuture = location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    LatLng? center = new LatLng(41.0, 41.0);
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
      body: Center(
        child: StreamBuilder(stream: deliveriesStream, builder: streamBuilder),
      ),
    );
  }
}
