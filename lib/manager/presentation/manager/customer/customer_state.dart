part of 'customer_bloc.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {}

class CustomerError extends CustomerState {
  final String error;

  CustomerError(this.error);
}
