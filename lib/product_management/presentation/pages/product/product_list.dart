import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';
import 'package:crm_machine_test/product_management/presentation/manager/product/product_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_pages.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ProductBloc productBloc;

  @override
  void initState() {
    productBloc = ProductBloc.get(context);
    productBloc.add(LoadProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(LineAwesomeIcons.arrow_left),
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(AppPages.productEdit);
            },
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.enableButtonColor,
              ),
              child: const Icon(LineAwesomeIcons.plus, color: AppColors.white),
            ),
          )
        ],
      ),
      body: ListView(
        children: [_buildSearchAndFilter(), _buildCustomerList()],
      ),
    );
  }

  _buildCustomerList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state is ProductLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is ProductLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return ProductTile(model: state.data[index]);
                    })
                : const SizedBox();
      },
    );
  }

  _buildSearchAndFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _searchController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            Future.delayed(const Duration(milliseconds: 400),
                                () {
                              productBloc.add(LoadProductEvent(search: val));
                            });
                          } else {
                            productBloc.add(LoadProductEvent());
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Search...",
                            suffixIcon: _searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      productBloc.add(LoadProductEvent());
                                    },
                                    child: const Icon(Icons.clear))
                                : const Icon(Icons.search)),
                      );
                    },
                  ),
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(AppPages.qr);
                  },
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: 35,
                  ),
                ))
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(),
        )
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductEntity model;

  const ProductTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppPages.productDetail, extra: model);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: 80,
                  height: 80,
                  // margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.dartGrey)),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model.measurement,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(model.price.toStringAsFixed(2))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
