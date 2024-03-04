import 'package:crm_machine_test/manager/domain/entities/menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<ChangeHomeItemEvent>((event, emit) {
      debugPrint("Changing menu ${event.selectedItem}");
      emit(HomeMenuChanged(event.selectedItem));
    });
  }
  static List<MenuItem> menuItems = [
    MenuItem(index: 0, name: "Home", icon: LineAwesomeIcons.home),
    MenuItem(index: 1, name: "Customers", icon: LineAwesomeIcons.people_carry),
    MenuItem(
        index: 2,
        name: "Managers",
        icon: LineAwesomeIcons.person_entering_booth),
    MenuItem(index: 3, name: "Notifications", icon: LineAwesomeIcons.bell),
  ];

  static HomeBloc get(context) => BlocProvider.of(context);
}
