import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/services/db/products_rep.dart';
import 'package:ium_warehouse/src/services/db/server_api.dart';
import 'package:ium_warehouse/src/services/db/users_rep.dart';

void injectServices() {
  GetIt.I.registerSingleton<ProductsRepository>(ProductsRepository());
  GetIt.I.registerSingleton<UserRepository>(UserRepository());
  GetIt.I.registerSingleton<ServerApi>(ServerApi());
}