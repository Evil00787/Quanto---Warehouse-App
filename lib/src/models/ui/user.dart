import 'package:ium_warehouse/src/models/db_strings.dart';

class UIUser {
  final String email;
  final Role role;

  UIUser(this.email, this.role);
  UIUser.fromJson(Map<String, dynamic> json) : email = json[DbUsersStrings.email],  role = Role.values[int.parse(json[DbUsersStrings.role])];
}

enum Role {
  Employee,
  Manager,
  Admin
}
