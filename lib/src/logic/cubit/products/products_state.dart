part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsSuccess extends ProductsState {
  final List<UIProduct> products;

  ProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);

  @override
  List<Object> get props => [message];
}


class ProductsUpdateSuccess extends ProductsState {
  @override
  List<Object> get props => [];
}