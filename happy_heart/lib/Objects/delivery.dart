import 'package:happy_heart/header.dart';

class Delivery {
  late AddressLocation srcLocation;
  late AddressLocation dstLocation;
  late String productId;
  late String productName;
  late String status;
  late int timeStamp;


  Delivery(this.srcLocation, this.dstLocation, this.productId, this.productName, {this.status="toBeDelivered"}){
    timeStamp = DateTime.now().millisecondsSinceEpoch;
  }
  Delivery.fromJson(Map json) {
    srcLocation = AddressLocation(json['srcAddress'], json['srcLat'].toDouble(), json['srcLng'].toDouble());
    dstLocation = AddressLocation(json['dstAddress'], json['dstLat'].toDouble(), json['dstLng'].toDouble());
    productId = json['productId'];
    productName = json['productName'];
    status = json['status'];
    timeStamp = json['timeStamp'];

  }

  Map<String, dynamic> toJson() => {
        'srcAddress': srcLocation.address,
        'srcLat': srcLocation.lat,
        'srcLng': srcLocation.lng,
        'dstAddress': dstLocation.address,
        'dstLat': dstLocation.lat,
        'dstLng': dstLocation.lng,
        'productId': productId,
        'productName' : productName,
        'status' : status,
        'timeStamp' : timeStamp,
      };

  String getDescription(){
    return "שינוע של " + productName + ".";
  }
  getLocationDescription(){
    return  "מ-" + srcLocation.address + " ל- " + dstLocation.address + ".";
  }
  String getDateDescription(){
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    String date = tsdate.day.toString() + "/" + tsdate.month.toString() + "/" + tsdate.year.toString();
    String houer = tsdate.hour.toString() + ":" + tsdate.minute.toString();

    return "בקשת השינוע התקבלה בתאריך " + date +". בשעה " + houer +" .";
  }
}
