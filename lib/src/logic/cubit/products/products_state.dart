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
  @override
  List<Object> get props => [];
}

class ProductsAddedSuccess extends ProductsState {
  final List<UIProduct> products;

  ProductsAddedSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsUpdateSuccess extends ProductsState {
  final List<UIProduct> products;

  ProductsUpdateSuccess(this.products);

  @override
  List<Object> get props => [products];
}