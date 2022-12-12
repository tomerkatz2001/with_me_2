import '../header.dart';

class Volunteer {
  String name;
  String email;
  // TODO: add another information about the volunteer

  Volunteer(this.name, this.email);

  getVolunteerData() {
    return {
      "name": name,
      "email": email,
    };
  }
}