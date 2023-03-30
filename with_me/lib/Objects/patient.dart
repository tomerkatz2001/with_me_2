import '../header.dart';

// TODO: check if need it
// class Role {
//   String role;
//
//   Role({required this.role}); // should be 'manger'/'volunteer'/'caller'
// }

class Patient {
  String id;
  String name;
  String email;
  List? dayTasks;
  // TODO: add another information about the volunteer

  Patient(this.name,this.id, this.email, {this.dayTasks});

  Map<String, dynamic> toMap(){
    var map= {"name":name,"email":email, 'dayTasks':dayTasks};
    return map;
  }
  Patient.fromMap(Map<String,dynamic> data,String id):
        this(
        data["name"],
        id,
        data['email'],
        dayTasks:data['dayTasks']
      );

}