import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ium_warehouse/src/models/json/json_product.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';
import 'package:ium_warehouse/src/services/db/products_rep.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static final ProductsRepository _productsRepository = GetIt.I<ProductsRepository>();
  List<dynamic> add = [];
  List<dynamic> update = [];
  List<dynamic> delete = [];
  List<dynamic> quantity = [];


  Future<void> getProducts() async {
    List<UIProduct> response = await _productsRepository.getProducts();
    emit(ProductsSuccess(response));
  }

  Future<UIProduct> getProduct(String id) async {
    return await _productsRepository.getProduct(JsonProduct(id: id));
  }

  Future<List<dynamic>> addProduct(String man, String model, String price) async {
    JsonProduct product = JsonProduct(manufacturer: man, model: model, price: double.tryParse(price), quantity: 0);
    UIProduct ui = await _productsRepository.addProduct(product);
    if(ui != null) {
      emit(ProductsInitial());
      return [true, ui.id];
    }
    else emit(ProductsError("Couldn't add a product. Check Internet connection and try again."));
    return [false, null];
  }

  Future<bool> updateProduct(String man, String model, String price, String id) async {
    JsonProduct product = JsonProduct(manufacturer: man, model: model, price: double.tryParse(price), id: id);
    UIProduct ui = await _productsRepository.updateProduct(product);
    if(ui != null) {
      emit(ProductsUpdateSuccess());
      return true;
    }
    else emit(ProductsError("Couldn't update a product. Check Internet connection and try again."));
    return false;
  }

  Future<bool> changeQuantity(String id, int quantity) async {
    JsonProduct product = JsonProduct(id: id, quantity: quantity);
    UIProduct uiProduct = await getProduct(id);
    if(uiProduct == null) {
      emit(ProductsError("Couldn't update a product. Check Internet connection and try again."));
      return false;
    }
    else if(uiProduct.quantity + quantity < 0) {
      emit(ProductsError("Quantity cannot be negative."));
      return false;
    } else {
      bool result = await _productsRepository.updateQuantityProduct(product);
      if(result) {
        emit(ProductsUpdateSuccess());
        return true;
      }
      else emit(ProductsError("Couldn't update a product. Check Internet connection and try again."));
      return false;
    }

  }

  Future<bool> deleteProduct(String id) async {
    JsonProduct product = JsonProduct(id: id);
    bool result = await _productsRepository.deleteProduct(product);
    if(result) {
      emit(ProductsUpdateSuccess());
    }
    else emit(ProductsError("Couldn't delete a product. Check Internet connection and try again."));
    return result;
  }

  void resetState() {
    emit(ProductsInitial());
  }

  Future<void> doOnlineStuff() async {
    List<bool> rem = [];
    for(var list in add) {
      dynamic ok = (await addProduct(list[0], list[1], list[2]));
      if(ok[0]) {
        rem.add(true);
        update = update.map((e) {if(e[3] == list[3]) e[3] = ok[1]; return e;}).toList();
        delete = delete.map((e) {if(e[0] == list[3]) e = ok[1]; return e;}).toList();
        quantity = quantity.map((e) {if(e[0] == list[3]) e[0] = ok[1]; return e;}).toList();
      } else rem.add(false);
    }
    for(int i = rem.length-1; i >=0;i--) {
      if(rem[i]) add.removeAt(i);
    }
    rem.clear();
    for(var list in update) {
      if(await updateProduct(list[0], list[1], list[2], list[3])) {
        rem.add(true);
      } else rem.add(false);
    }
    for(int i = rem.length-1; i >=0;i--) {
      if(rem[i]) update.removeAt(i);
    }
    rem.clear();
    for(var list in delete) {
      if(await deleteProduct(list[0])) {
        rem.add(true);
      } else rem.add(false);
    }
    for(int i = rem.length-1; i >=0;i--) {
      if(rem[i]) delete.removeAt(i);
    }
    rem.clear();
    for(var list in quantity) {
      if(await changeQuantity(list[0], list[1])) {
        rem.add(true);
      } else rem.add(false);
    }
    for(int i = rem.length-1; i >=0;i--) {
      if(rem[i]) quantity.removeAt(i);
    }
  }


}
