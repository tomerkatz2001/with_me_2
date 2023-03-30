import '../header.dart';

// TODO: check if need it
// class Role {
//   String role;
//
//   Role({required this.role}); // should be 'manger'/'volunteer'/'caller'
// }

class Client {
  String id;
  String name;
  String email;
  int permission;
  // TODO: add another information about the volunteer

  Client(this.name,this.id, this.email, this.permission);

  Map<String, dynamic> toMap(){
    var map= {"name":name,"email":email, 'permission':permission};
    return map;
  }
  Client.fromMap(Map<String,dynamic> data,String id):
        this(
          data["name"],
          id,
          data['email'],
          data['permission']
      );

}