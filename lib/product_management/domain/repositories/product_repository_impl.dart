import 'package:crm_machine_test/product_management/data/data_sources/product_data_source.dart';
import 'package:crm_machine_test/product_management/data/models/product_model.dart';
import 'package:crm_machine_test/product_management/data/repositories/product_repository.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<void> addProduct(ProductModel model) {
    return dataSource.addProduct(model);
  }

  @override
  Future<void> editProduct(ProductModel model) {
    return dataSource.editProduct(model);
  }

  @override
  Future<List<ProductEntity>> getProducts({String? search}) {
    return dataSource.getProducts(search: search);
  }
}
