import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/models/json/json_product.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/services/db/api_addresses.dart';
import 'package:ium_warehouse/src/services/db/server_api.dart';
import 'package:localstorage/localstorage.dart';

ServerApi api = GetIt.I<ServerApi>();

class ProductsRepository {
  bool isOnilne = true;

  final LocalStorage storage = new LocalStorage('products');
  Future<List<UIProduct>> getProducts() async {
    dynamic json;
    if(isOnilne) {
      json = await api.getDb(ProductAddresses.products);
      saveToLocalStorage(json);
    }
    else json = await getLocalProducts();
    if (json is bool) {
      return null;
    }
    List<UIProduct> products = (json as List).map((e) => UIProduct.fromJson(e)).toList();
    return products;
  }

  Future<UIProduct> getProduct(JsonProduct product) async {
    dynamic json;
    if(isOnilne) {
      json = await api.getDb(withId(ProductAddresses.product, product.id));
    }
    else return UIProduct.fromJson((await getJsonById(product.id)).toJson());
    if (json is bool || json.containsKey('error')) {
      return null;
    }
    return UIProduct.fromJson(json);

  }

  Future<UIProduct> addProduct(JsonProduct product) async {
    dynamic json;
    if(isOnilne) {
      json = await api.postDb(product.toJson(),ProductAddresses.product);
      if (json is bool || json.containsKey('error')) {
        return null;
      }
    }
    else return await saveItemToLocalStorage(product);
    return UIProduct.fromJson(json);
  }

  Future<UIProduct> updateProduct(JsonProduct product) async {
    dynamic json;
    if(isOnilne) {
      json = await api.putDb(product.toJson(), withId(ProductAddresses.product, product.id));
      if (json.containsKey('error')) {
        return null;
      }
    }
    else return await saveItemToLocalStorage(product, add: false);
    return UIProduct.fromJson(json);
  }

  Future<bool> updateQuantityProduct(JsonProduct product) async {
    Map<String, dynamic> json;
    if(isOnilne) {
      json = await api.patchDb(product.toJson(), withId(ProductAddresses.product, product.id));
      if (json.containsKey('error')) {
        return false;
      }
    }
    else return await saveItemToLocalStorage(product, add: false, quantity: true) is UIProduct;
    return true;
  }

  Future<bool> deleteProduct(JsonProduct product) async {
    dynamic json;
    if(isOnilne) {
      json = await api.deleteDb(withId(ProductAddresses.product, product.id));
      if (json is bool || json.containsKey('error')) {
        return false;
      }
    }
    else return await saveItemToLocalStorage(product, add: false, delete: true) is JsonProduct;
    return json.containsKey("success");
  }


  Future<void> saveToLocalStorage(dynamic list) async {
    await storage.ready;
    storage.setItem("products", list);
  }

  Future<void> saveProductsToLocalStorage(List<JsonProduct> jProd) async {
    List<dynamic> list = [];
    for(var p in jProd) {
      list.add(p.toJson());
    }
    saveToLocalStorage(list);
  }

  Future<UIProduct> saveItemToLocalStorage(JsonProduct product, {bool add = true, bool quantity = false, bool delete = false}) async {
    List<JsonProduct> jProd = getJsonProducts(await getLocalProducts());
    UIProduct a;
    if(!add && !delete) {
      int i;
      i = jProd.indexWhere((element) => element.id == product.id);
      jProd[i] = jProd[i].copy(product, pathQuantity: quantity);
      a = UIProduct.fromJson(jProd[i].toJson());
    } else if (delete) {
      jProd.retainWhere((element) => element.id != product.id);
      a = UIProduct.fromJson(jProd.last.toJson());
    } else if(add) {
      jProd.add(JsonProduct(id: ObjectId().toString()).copy(product));
      a = UIProduct.fromJson(jProd.last.toJson());
    }
    saveProductsToLocalStorage(jProd);
    return a;
  }

  dynamic getLocalProducts() async {
    await storage.ready;
    return await storage.getItem("products");
  }

  List<JsonProduct> getJsonProducts(dynamic products) {
    List<JsonProduct> jProd = [];
    for(var pr in products) {
      jProd.add(JsonProduct.fromProduct(UIProduct.fromJson(pr)));
    }
    return jProd;
  }

  Future<JsonProduct> getJsonById(String id) async {
    return getJsonProducts(await getLocalProducts()).singleWhere((element) => element.id == id);
  }
}