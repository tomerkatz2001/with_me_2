import '../header.dart';

// TODO: check if need it
// class Role {
//   String role;
//
//   Role({required this.role}); // should be 'manger'/'volunteer'/'caller'
// }

class Station {
  String? name;
  String? location;
  String? time;
  // TODO: add another information about the volunteer

  Station(this.name, this.location, this.time);

  Station.fromMap(Map<String, dynamic> data):
      this(
        data["name"] ?? "אין שם",
        data["location"] ?? "טרם נקבע מיקום",
        data["time"] ?? "אין זמן מוערך"
      );

    Map<String, dynamic> toMap() {
      return {"name": this.name,
        "location": this.location,
        "time": this.time,
      };
    }



}