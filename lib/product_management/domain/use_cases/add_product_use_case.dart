import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/models/product_model.dart';
import 'package:crm_machine_test/product_management/data/repositories/product_repository.dart';

class AddProductUseCase extends UseCase<void, ProductModel> {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<void> call(ProductModel params) {
    return repository.addProduct(params);
  }
}
