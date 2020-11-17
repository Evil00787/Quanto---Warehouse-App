import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/models/json/json_product.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/services/db/api_addresses.dart';
import 'package:ium_warehouse/src/services/db/server_api.dart';

ServerApi api = GetIt.I<ServerApi>();

class ProductsRepository {
  Future<List<UIProduct>> getProducts() async {
    dynamic json = await api.getDb(ProductAddresses.products);
    return (json as List).map((e) => UIProduct.fromJson(e)).toList();
  }

  Future<UIProduct> getProduct(JsonProduct product) async {
    dynamic json = await api.postDb(product.toJson(), ProductAddresses.product);
    return UIProduct.fromJson(json);
  }

  Future<UIProduct> addProduct(JsonProduct product) async {
    dynamic json = await api.postDb(product.toJson(), ProductAddresses.add);
    return UIProduct.fromJson(json);
  }

  Future<UIProduct> updateProduct(JsonProduct product) async {
    dynamic json = await api.postDb(product.toJson(), ProductAddresses.update);
    return UIProduct.fromJson(json);
  }

  Future<bool> updateQuantityProduct(JsonProduct product) async {
    Map<String, dynamic> json = await api.postDb(product.toJson(), ProductAddresses.quantity);
    if (json.containsKey('error')) {
      return false;
    }
    return true;
  }

  Future<bool> deleteProduct(JsonProduct product) async {
    Map<String, dynamic> json = await api.postDb(product.toJson(), ProductAddresses.delete);
    return json.containsKey('_id');
  }
}