import 'package:equatable/equatable.dart';
import 'package:ium_warehouse/src/models/db_strings.dart';

class UIUser extends Equatable {
  final String email;
  final Role role;

  UIUser(this.email, this.role);
  UIUser.fromJson(Map<String, dynamic> json) : email = json[DbUsersStrings.email],  role = Role.values[int.parse(json[DbUsersStrings.role])];

  @override
  List<Object> get props => [email, role.index];
}

enum Role {
  Employee,
  Manager,
  Admin
}
