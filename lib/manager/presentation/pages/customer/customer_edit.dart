import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/presentation/manager/customer/customer_bloc.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
import 'package:crm_machine_test/manager/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: CustomerEdit(),
  ));
}

class CustomerEdit extends StatefulWidget {
  final CustomerModel? model;

  const CustomerEdit({super.key, this.model});

  @override
  State<CustomerEdit> createState() => _CustomerEditState();
}

class _CustomerEditState extends State<CustomerEdit> {
  final _formKey = GlobalKey<FormState>();

  ///text controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _mailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _monthlyCollectionController = TextEditingController();

  ///end of text controllers

  late CustomerBloc customerBloc;

  addData() {
    _firstNameController.text = widget.model?.firstName ?? "";
    _lastNameController.text = widget.model?.lastName ?? "";
    _phoneNumberController.text = widget.model?.phoneNumber ?? "";
    _mailController.text = widget.model?.mail ?? "";
    _addressController.text = widget.model?.address ?? "";
    _cityController.text = widget.model?.city ?? "";
    _monthlyCollectionController.text =
        widget.model?.monthlyDue.toStringAsFixed(2) ?? "";
  }

  @override
  void initState() {
    if (widget.model != null) {
      addData();
    }

    customerBloc = CustomerBloc.get(context);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _mailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _monthlyCollectionController.dispose();
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
        title: Text("${widget.model == null ? 'Add' : 'Edit'} Customer"),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            if (widget.model?.id == null) {
              customerBloc.add(AddCustomerEvent(CustomerModel(
                  city: _cityController.text,
                  address: _addressController.text,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phoneNumber: _phoneNumberController.text,
                  mail: _mailController.text,
                  monthlyDue:
                      double.tryParse(_monthlyCollectionController.text) ?? 0,
                  joinedDate: DateTime.now())));
            } else {
              customerBloc.add(UpdateCustomer(CustomerModel(
                city: _cityController.text,
                address: _addressController.text,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                phoneNumber: _phoneNumberController.text,
                mail: _mailController.text,
                monthlyDue:
                    double.tryParse(_monthlyCollectionController.text) ?? 0,
              )));
            }
          }
        },
        child: const Text('Save'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            CustomTextField(
              controller: _firstNameController,
              title: "First Name",
              topBorder: true,
            ),
            CustomTextField(
              controller: _lastNameController,
              title: "Last Name",
            ),
            CustomTextField(
              controller: _phoneNumberController,
              title: "Phone Number",
              textInputType: TextInputType.number,
            ),
            CustomTextField(
              controller: _mailController,
              title: "Mail (Optional)",
            ),
            CustomTextField(
              controller: _addressController,
              title: "Address",
              lines: 3,
            ),
            CustomTextField(
              controller: _cityController,
              title: "City",
            ),
            CustomTextField(
              controller: _monthlyCollectionController,
              textInputType: TextInputType.number,
              title: "Monthly Collection",
              bottomBorder: true,
            ),
          ],
        ),
      ),
    );
  }
}
