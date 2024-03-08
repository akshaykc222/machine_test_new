import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';
import 'package:crm_machine_test/product_management/presentation/manager/product/product_bloc.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_constants.dart';
import 'package:crm_machine_test/product_management/presentation/utils/app_theme.dart';
import 'package:crm_machine_test/product_management/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: ProductEdit(),
  ));
}

class ProductEdit extends StatefulWidget {
  final ProductEntity? model;

  const ProductEdit({super.key, this.model});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final _formKey = GlobalKey<FormState>();
  late ProductBloc productBloc;

  ///text controllers
  final _nameController = TextEditingController();
  final _measurementController = TextEditingController();
  final _priceController = TextEditingController();

  ///end of text controllers

  // late CustomerBloc customerBloc;

  addData() {
    _nameController.text = widget.model?.name ?? "";
    _measurementController.text = widget.model?.measurement ?? "";
    _priceController.text = widget.model?.price.toStringAsFixed(2) ?? "";
  }

  @override
  void initState() {
    if (widget.model != null) {
      addData();
    }
    productBloc = ProductBloc.get(context);
    productBloc.add(ProductEditEvent());

    // customerBloc = CustomerBloc.get(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _measurementController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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
        centerTitle: true,
        title: Text("${widget.model == null ? 'Add' : 'Edit'} Product"),
      ),
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state is ProductLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      productBloc.add(ProductAddEvent(
                          context: context,
                          model: ProductEntity(
                            id: widget.model?.id,
                            name: _nameController.text,
                            measurement: _measurementController.text,
                            price:
                                double.tryParse(_priceController.text) ?? 0.0,
                          )));
                    }
                  },
                  child: const Text('Save'),
                );
        },
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            CustomTextField(
              controller: _nameController,
              title: "Product Name",
              topBorder: true,
              validator: (val) {
                if (val.isEmpty) {
                  return "Enter valid name";
                }
              },
            ),
            CustomTextField(
              controller: _measurementController,
              title: "Measurement",
              validator: (val) {
                if (val.isEmpty) {
                  return "Enter valid Measurement";
                }
              },
            ),
            CustomTextField(
              controller: _priceController,
              title: "Price",
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              bottomBorder: true,
              validator: (val) {
                if (val.isEmpty) {
                  return "Enter valid price";
                }
              },
            ),
            spacer10,
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return state is ProductAddError
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.errorRed,
                        ),
                        child: Text(
                          state.error,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      )
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
