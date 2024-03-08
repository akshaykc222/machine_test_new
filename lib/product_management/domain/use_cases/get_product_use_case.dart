import 'package:crm_machine_test/core/usecase.dart';
import 'package:crm_machine_test/product_management/data/repositories/product_repository.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';

class GetProductUseCase extends UseCase<List<ProductEntity>, String?> {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  @override
  Future<List<ProductEntity>> call(String? params) {
    return repository.getProducts(search: params);
  }
}
