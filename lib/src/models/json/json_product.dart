import 'package:ium_warehouse/src/models/db_strings.dart';
import 'package:ium_warehouse/src/models/ui/product.dart';

class JsonProduct{
  final String id;
  final String manufacturer;
  final String model;
  final double price;
  final int quantity;

  JsonProduct({this.manufacturer, this.model, this.price, this.quantity, this.id});
  JsonProduct.fromProduct(UIProduct product) : this.id = product.id, this.model = product.modelName, this.manufacturer = product.manufacturer, this.quantity = product.quantity, this.price = product.price;

  Map<String, dynamic> toJson() =>
    {
      if(id != null) DbProductStrings.id: id,
      if(manufacturer != null) DbProductStrings.manufacturer: manufacturer,
      if(model != null) DbProductStrings.model: model,
      if(price != null) DbProductStrings.price: price,
      if(quantity != null) DbProductStrings.quantity: quantity
    };

  JsonProduct copy(JsonProduct product, {bool pathQuantity = false}) =>
     JsonProduct(id: id, manufacturer: product.manufacturer != null ? product.manufacturer : manufacturer, model: product.model != null ? product.model : model, price: product.price != null ? product.price : price, quantity: product.quantity != null ? pathQuantity ? quantity + product.quantity : product.quantity : quantity);
}