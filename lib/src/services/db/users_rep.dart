import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/models/json/json_user.dart';
import 'package:ium_warehouse/src/models/ui/user.dart';
import 'package:ium_warehouse/src/services/db/api_addresses.dart';
import 'package:ium_warehouse/src/services/db/server_api.dart';

ServerApi api = GetIt.I<ServerApi>();

class UserRepository {
  Future<dynamic> login(JsonUser user) async {
    dynamic json = await api.postDb(user.toJson(), UserAddresses.login);
    if ((json as Map<String, dynamic>).containsKey('success')) {
      if (json['success'] == false)
        return false;
    }
    else if ((json as Map<String, dynamic>).containsKey('connection')) {
      if (json['connection'] == false)
        return true;
    }
    return UIUser.fromJson(json);
  }

  Future<bool> logout() async {
    dynamic json = await api.getDb(UserAddresses.logout);
    return json['success'] as bool;
  }
}