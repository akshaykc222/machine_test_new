import 'package:crm_machine_test/product_management/data/models/product_model.dart';
import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/add_product_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/edit_product_use_case.dart';
import 'package:crm_machine_test/product_management/domain/use_cases/get_product_use_case.dart';
import 'package:crm_machine_test/product_management/injector.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_pages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final data = await getProductUseCase.call(event.search);
        emit(ProductLoaded(data));
      } catch (e) {
        emit(ProductFetchError(e.toString()));
      }
    });
    on<ProductAddEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        if (event.model.id != null) {
          await editProductUseCase.call(ProductModel.fromEntity(event.model));
        } else {
          await addProductUseCase.call(ProductModel.fromEntity(event.model));
        }

        emit(ProductInitial());
        add(LoadProductEvent());
        Future.delayed(Duration.zero, () {
          GoRouter.of(event.context).goNamed(AppPages.productList);
        });
      } catch (e) {
        emit(ProductAddError(e.toString()));
      }
    });
    on<ProductEditEvent>((event, emit) => emit(ProductInitial()));
    on<SearchQrCodeEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final data = await getProductUseCase.call(event.search);
        if (data.isNotEmpty) {
          GoRouter.of(event.context)
              .pushNamed(AppPages.productDetail, extra: data.first);
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(content: Text("No products found..")));
        }
        emit(ProductLoaded(data));
      } catch (e) {
        emit(ProductFetchError(e.toString()));
      }
    });
  }

  ///use cases
  final addProductUseCase = sl<AddProductUseCase>();
  final editProductUseCase = sl<EditProductUseCase>();
  final getProductUseCase = sl<GetProductUseCase>();

  static ProductBloc get(context) => BlocProvider.of(context);
}
