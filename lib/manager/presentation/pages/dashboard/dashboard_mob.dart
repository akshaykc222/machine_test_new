import 'package:crm_machine_test/manager/presentation/manager/home/home_bloc.dart';
import 'package:crm_machine_test/manager/presentation/pages/customer/customer_list.dart';
import 'package:crm_machine_test/manager/presentation/pages/home/home_mob.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: const DashBoardMob(),
  ));
}

class DashBoardMob extends StatefulWidget {
  const DashBoardMob({super.key});

  @override
  State<DashBoardMob> createState() => _DashBoardMobState();
}

class _DashBoardMobState extends State<DashBoardMob> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: HomeBloc.menuItems
                .map((e) => BottomNavigationBarItem(
                    icon: Icon(
                      e.icon,
                      color:
                          (state is HomeMenuChanged ? state.selectedItem : 0) ==
                                  e.index
                              ? AppColors.enableButtonColor
                              : AppColors.dartGrey,
                    ),
                    label: e.name))
                .toList(),
            currentIndex: state is HomeMenuChanged ? state.selectedItem : 0,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              debugPrint("Tapping");
              homeBloc.add(ChangeHomeItemEvent(index));
            },
          ),
          body: SafeArea(
            top: true,
            child: _getHomeWidget(
                state is HomeMenuChanged ? state.selectedItem : 0),
          ),
        );
      },
    );
  }

  Widget _getHomeWidget(int index) {
    switch (index) {
      case 0:
        return const HomeMob();
      case 1:
        return const CustomerListScreen();
      default:
        return const HomeMob();
    }
  }
}
