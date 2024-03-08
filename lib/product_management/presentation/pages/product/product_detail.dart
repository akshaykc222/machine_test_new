import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';
import 'package:crm_machine_test/product_management/presentation/manager/product/product_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntity model;

  const ProductDetail({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (d) {
        ProductBloc.get(context).add(LoadProductEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left),
          ),
          actions: [],
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 10),
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
                  Expanded(
                      flex: 2,
                      child: QrImageView(
                        data: model.name,
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("Name"),
                            subtitle: Text(model.name),
                          ),
                          ListTile(
                            title: const Text("Measurement"),
                            subtitle: Text(model.measurement),
                          ),
                          ListTile(
                            title: const Text("Price"),
                            subtitle: Text(model.price.toStringAsFixed(2)),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
