import 'package:happy_heart/header.dart';

class Delivery {
  late Location srcLocation;
  late Location dstLocation;
  late String productId;

  Delivery(this.srcLocation, this.dstLocation, this.productId);
  Delivery.fromJson(Map json) {
    srcLocation = Location(json['srcAddress'], json['srcLat'], json['srcLng']);
    dstLocation = Location(json['dstAddress'], json['dstLat'], json['dstLng']);
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() => {
        'srcAddress': srcLocation.address,
        'srcLat': srcLocation.lat,
        'srcLng': srcLocation.lng,
        'dstAddress': dstLocation.address,
        'dstLat': dstLocation.lat,
        'dstLng': dstLocation.lng,
        'productId': productId
      };
}
