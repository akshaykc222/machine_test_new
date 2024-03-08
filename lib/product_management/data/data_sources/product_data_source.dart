import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_machine_test/core/custom_exceptions.dart';
import 'package:crm_machine_test/core/firebase_service.dart';
import 'package:crm_machine_test/product_management/data/data_sources/collections.dart';
import 'package:crm_machine_test/product_management/data/models/product_model.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';

abstract class ProductDataSource {
  Future<void> addProduct(ProductModel model);
  Future<void> editProduct(ProductModel model);
  Future<List<ProductEntity>> getProducts({String? search});
}

class ProductDataSourceImpl extends ProductDataSource {
  final FirebaseService firebaseService;

  ProductDataSourceImpl(this.firebaseService);

  @override
  Future<void> addProduct(ProductModel model) async {
    try {
      DocumentReference productRef = FirebaseFirestore.instance
          .collection(Collections.products)
          .doc(model.name);
      DocumentSnapshot productSnapshot = await productRef.get();
      if (!productSnapshot.exists) {
        await productRef.set(model.toJson());
      } else {
        throw CustomException("Product name already exists!");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editProduct(ProductModel model) async {
    try {
      await firebaseService.updateData(model.id ?? "", model.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductEntity>> getProducts({String? search}) async {
    CollectionReference productsRef =
        FirebaseFirestore.instance.collection(Collections.products);

    if (search != null && search.isNotEmpty) {
      String searchTerm = search.toLowerCase();

      QuerySnapshot querySnapshot = await productsRef
          .where('name', isGreaterThanOrEqualTo: searchTerm)
          .where('name', isLessThanOrEqualTo: "${searchTerm}z")
          .get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc))
          .toList();
    } else {
      QuerySnapshot querySnapshot = await productsRef.get();

      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc))
          .toList();
    }
  }
}
