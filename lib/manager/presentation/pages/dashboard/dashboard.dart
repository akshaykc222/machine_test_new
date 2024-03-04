import 'package:crm_machine_test/manager/presentation/pages/dashboard/dashboard_mob.dart';
import 'package:crm_machine_test/manager/presentation/pages/dashboard/dashboard_web.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isMobile) {
          return const DashBoardMob();
        } else {
          return const DashBoardWeb();
        }
      },
    );
  }
}
