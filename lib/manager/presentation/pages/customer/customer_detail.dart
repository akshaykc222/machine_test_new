import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/presentation/pages/customer/customer_list.dart';
import 'package:crm_machine_test/manager/presentation/router/app_pages.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_constants.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: CustomerDetail(model: mockCustomers[0]),
  ));
}

class CustomerDetail extends StatelessWidget {
  final CustomerModel model;

  const CustomerDetail({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(LineAwesomeIcons.arrow_left),
        ),
        actions: [
          TextButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(AppPages.customerEdit, extra: model);
              },
              child: const Text("Request edit access"))
        ],
      ),
      body: ListView(
        children: [
          _buildCustomerDetail(context),
          ListTile(
            title: const Text(
              "Monthly Collection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(model.monthlyDue.toStringAsFixed(2)),
          ),
          ListTile(
            title: const Text(
              "Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(model.notes ?? ""),
          )
        ],
      ),
    );
  }

  _buildCustomerDetail(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: AppColors.white),
            child: Column(
              children: [
                const Expanded(flex: 2, child: Row()),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          "${model.firstName}\t${model.lastName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "City",
                          style: TextStyle(fontSize: 18),
                        ),
                        spacer10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.mail_outline),
                                  ),
                                  Flexible(child: Text("${model.mail}")),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.phone_android),
                                  ),
                                  Text("${model.phoneNumber}"),
                                ],
                              )),
                            ],
                          ),
                        ),
                        spacer10,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(model.address),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.dartGrey),
                  color: AppColors.dartGrey
                  // borderRadius: BorderRadius.circular(10),
                  ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
