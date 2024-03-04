part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeMenuChanged extends HomeState {
  final int selectedItem;

  HomeMenuChanged(this.selectedItem);
}
