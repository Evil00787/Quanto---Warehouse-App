import 'package:ium_warehouse/src/models/db_strings.dart';

class JsonProduct{
  final String id;
  final String manufacturer;
  final String model;
  final double price;
  final int quantity;

  JsonProduct({this.manufacturer, this.model, this.price, this.quantity, this.id});

  Map<String, dynamic> toJson() =>
    {
      if(id != null) DbProductStrings.id: id,
      if(manufacturer != null) DbProductStrings.manufacturer: manufacturer,
      if(model != null) DbProductStrings.model: model,
      if(price != null) DbProductStrings.price: price,
      if(quantity != null) DbProductStrings.quantity: quantity
    };
}