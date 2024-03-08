import 'package:crm_machine_test/product_management/data/models/product_model.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<void> addProduct(ProductModel model);
  Future<void> editProduct(ProductModel model);
  Future<List<ProductEntity>> getProducts({String? search});
}
