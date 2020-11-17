import 'package:ium_warehouse/src/models/db_strings.dart';

class JsonUser{
  final String id;
  final String email;
  final String password;
  final String idToken;

  JsonUser({this.email, this.password, this.id, this.idToken});

  Map<String, dynamic> toJson() =>
  {
    if(id != null) DbUsersStrings.id: id,
    if(email != null) DbUsersStrings.email: email,
    if(password != null) DbUsersStrings.password: password,
    if(idToken != null) DbUsersStrings.idToken: idToken
  };
}