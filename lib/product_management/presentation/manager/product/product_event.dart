part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class ProductAddEvent extends ProductEvent {
  final ProductEntity model;
  final BuildContext context;
  ProductAddEvent({required this.model, required this.context});

  @override
  List<Object?> get props => [model];
}

class ProductEditEvent extends ProductEvent {
  ProductEditEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductEvent extends ProductEvent {
  final String? search;

  LoadProductEvent({this.search});

  @override
  List<Object?> get props => [search];
}

class SearchQrCodeEvent extends ProductEvent {
  final String search;
  final BuildContext context;
  SearchQrCodeEvent(this.search, this.context);

  @override
  List<Object?> get props => [search];
}
