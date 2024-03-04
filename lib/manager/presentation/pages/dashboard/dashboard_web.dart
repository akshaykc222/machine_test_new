import 'package:crm_machine_test/manager/presentation/manager/home/home_bloc.dart';
import 'package:crm_machine_test/manager/presentation/pages/home/home_web.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: const DashBoardWeb(),
  ));
}

class DashBoardWeb extends StatefulWidget {
  const DashBoardWeb({super.key});

  @override
  State<DashBoardWeb> createState() => _DashBoardWebState();
}

class _DashBoardWebState extends State<DashBoardWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  children: [
                    _headCard(),
                    ...HomeBloc.menuItems
                        .map((e) => _menuCard(name: e.name, icon: e.icon))
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const HomeScreenWeb(),
              ))
        ],
      ),
    );
  }

  _headCard() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: const Center(
          child: Text(
        "Machine Test",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
      )),
    );
  }

  Widget _menuCard({required String name, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.bgColor),
      child: Row(
        children: [
          Icon(icon),
          Expanded(
              child: Center(
                  child: Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )))
        ],
      ),
    );
  }
}
