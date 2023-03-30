import '../header.dart';

// TODO: check if need it
// class Role {
//   String role;
//
//   Role({required this.role}); // should be 'manger'/'volunteer'/'caller'
// }

List<Station> toList(List<dynamic>? l) {
  List<Station> list = [];
  for (var d in l ?? []) {
    list.add(Station.fromMap(d));
  }
  return list;
}

class Patient {
  String id;
  String name;
  String email;
  List<Station>? dayTasks;
  // TODO: add another information about the volunteer

  Patient(this.name,this.id, this.email, {this.dayTasks});

  List<Map> ListOfMaps(){
    List<Map> l =[];
    for(var s in this.dayTasks??[]){
      l.add(s.toMap());
    }
    return l;
  }
  Map<String, dynamic> toMap(){
    var map= {"name":name,"email":email, 'dayTasks':ListOfMaps()};
    return map;
  }
  Patient.fromMap(Map<String,dynamic> data,String id):
        this(
        data["name"],
        id,
        data['email'],
        dayTasks:toList(data['dayTasks'])
      );


}