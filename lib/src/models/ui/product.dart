import 'package:equatable/equatable.dart';
import 'package:ium_warehouse/src/models/db_strings.dart';

class UIProduct extends Equatable{
  final String id;
  final String manufacturer;
  final String modelName;
  final double price;
  final int quantity;

  UIProduct(this.manufacturer, this.modelName, this.price, this.quantity, {this.id = ""});
  UIProduct.fromJson(Map<String, dynamic> json) : manufacturer = json[DbProductStrings.manufacturer], id = json[DbProductStrings.id],
    modelName = json[DbProductStrings.model], price = json[DbProductStrings.price], quantity = json[DbProductStrings.quantity];

  String toStringNice() {
    return manufacturer + " " + modelName + " - Price: " + price.toString() + " Quantity: " + quantity.toString();
  }

  @override
  List<Object> get props => [id, manufacturer, modelName, price, quantity];
}