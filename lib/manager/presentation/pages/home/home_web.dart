import 'dart:math';

import 'package:crm_machine_test/manager/domain/entities/chart_data.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_assets.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  List<ChartData> mockData = [];
  List<ChartData> generateMockDataForYear(int year) {
    Random random = Random();

    for (int i = 0; i < 12; i++) {
      String month = months[i];
      // Generate a random number of customers joined (between 50 and 200)
      int customersJoined = random.nextInt(151) + 50;
      mockData.add(ChartData(month, customersJoined));
    }

    return mockData;
  }

  @override
  void initState() {
    generateMockDataForYear(2024);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Overview",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        spacer10,
        Row(
          children: [
            overViewCard(
                title: "Total Customer",
                image: AppAssets.customer,
                content: "50"),
            overViewCard(
                title: "Total Customer",
                image: AppAssets.customer,
                content: "50"),
          ],
        ),
        Row(
          children: [
            overViewCard(
                title: "Total Customer",
                image: AppAssets.customer,
                content: "50"),
            overViewCard(
                title: "Total Customer",
                image: AppAssets.customer,
                content: "50"),
          ],
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Customers joined ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        spacer10,
        SfCartesianChart(
          // title: const ChartTitle(
          //     text: 'Customer Joined Months',
          //     alignment: ChartAlignment.near,
          //     textStyle:
          //         TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          primaryXAxis: const CategoryAxis(),
          series: [
            LineSeries<ChartData, String>(
              dataSource: mockData,
              xValueMapper: (ChartData sales, _) => sales.month,
              yValueMapper: (ChartData sales, _) => sales.customersJoined,
              name: 'Customers Joined',
            ),
          ],
        )
      ],
    );
  }

  Widget overViewCard(
      {required String title, required String image, required String content}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 16),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  image,
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.37)),
                )
              ],
            ),
            spacer10,
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                content,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}