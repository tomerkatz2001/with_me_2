import '../header.dart';

// TODO: check if need it
// class Role {
//   String role;
//
//   Role({required this.role}); // should be 'manger'/'volunteer'/'caller'
// }

class Volunteer {
  String name;
  String email;
  String role;
  // TODO: add another information about the volunteer

  Volunteer(this.name, this.email, {this.role = 'volunteer'});

  getVolunteerData() {
    return {
      "name": name,
      "email": email,
      "role": role,
    };
  }

}