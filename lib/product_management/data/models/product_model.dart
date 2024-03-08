import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {super.id,
      required super.name,
      required super.measurement,
      required super.price});

  factory ProductModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return ProductModel(
        id: doc.id,
        name: json['name'],
        measurement: json['measurement'],
        price: json['price']);
  }
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        name: entity.name,
        measurement: entity.measurement,
        price: entity.price);
  }
  toJson() => {'name': name, 'measurement': measurement, 'price': price};
}
