part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> data;

  ProductLoaded(this.data);
}

class ProductFetchError extends ProductState {
  final String error;

  ProductFetchError(this.error);
}

class ProductAddError extends ProductState {
  final String error;

  ProductAddError(this.error);
}
