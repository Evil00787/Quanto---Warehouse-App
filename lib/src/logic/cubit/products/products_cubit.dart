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

  Future<void> getProducts() async {
    List<UIProduct> response = await _productsRepository.getProducts();
    emit(ProductsSuccess(response));
  }

  Future<void> addProduct(String man, String model, String price, String id) async {
    JsonProduct product = JsonProduct(manufacturer: man, model: model, price: double.tryParse(price), quantity: 0);
    UIProduct ui = await _productsRepository.addProduct(product);
    if(ui != null) {
      emit(ProductsInitial());
    }
    else emit(ProductsError());
  }

  Future<void> updateProduct(String man, String model, String price, String id) async {
    JsonProduct product = JsonProduct(manufacturer: man, model: model, price: double.tryParse(price), id: id);
    UIProduct ui = await _productsRepository.updateProduct(product);
    if(ui != null) {
      emit(ProductsInitial());
    }
    else emit(ProductsError());
  }

  Future<void> changeQuantity(String id, int quantity) async {
    JsonProduct product = JsonProduct(id: id, quantity: quantity);
    bool result = await _productsRepository.updateQuantityProduct(product);
    if(result) {
      emit(ProductsInitial());
    }
    else emit(ProductsError());
  }

  Future<void> deleteProduct(String id) async {
    JsonProduct product = JsonProduct(id: id);
    bool result = await _productsRepository.deleteProduct(product);
    if(result) {
      emit(ProductsInitial());
    }
    else emit(ProductsError());
  }

  void resetState() {
    emit(ProductsInitial());
  }

}
