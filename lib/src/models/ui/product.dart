import 'package:ium_warehouse/src/models/db_strings.dart';

class UIProduct {
  final String id;
  final String manufacturer;
  final String modelName;
  final double price;
  final int quantity;

  UIProduct(this.manufacturer, this.modelName, this.price, this.quantity, {this.id = ""});
  UIProduct.fromJson(Map<String, dynamic> json) : manufacturer = json[DbProductStrings.manufacturer], id = json[DbProductStrings.id],
    modelName = json[DbProductStrings.model], price = json[DbProductStrings.price], quantity = json[DbProductStrings.quantity];
}