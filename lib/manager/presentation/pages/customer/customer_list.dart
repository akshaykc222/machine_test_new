import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_machine_test/manager/data/data_sources/collections.dart';
import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/presentation/router/app_pages.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:crm_machine_test/manager/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.primaryTheme,
    home: const CustomerListScreen(),
  ));
}

List<CustomerModel> mockCustomers = [
  CustomerModel(
    firstName: 'Alice',
    lastName: 'Smith',
    phoneNumber: '1234567890',
    mail: 'alice@example.com',
    monthlyDue: 150.0,
    notes: 'Regular customer',
    city: '',
    address: '',
  ),
  CustomerModel(
    firstName: 'Bob',
    lastName: 'Johnson',
    phoneNumber: '9876543210',
    mail: 'bob@example.com',
    monthlyDue: 200.0,
    notes: 'VIP customer',
    city: '',
    address: '',
  ),
  CustomerModel(
    firstName: 'Charlie',
    lastName: 'Brown',
    phoneNumber: '5555555555',
    mail: 'charlie@example.com',
    monthlyDue: 100.0,
    city: '',
    address: '',
  ),
];

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    _stream =
        FirebaseFirestore.instance.collection(Collections.customer).snapshots();
    super.initState();
  }

  void search(String query) {
    setState(() {
      _stream = FirebaseFirestore.instance
          .collection(Collections.customer)
          .where('name', isGreaterThanOrEqualTo: query)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(LineAwesomeIcons.arrow_left),
        title: const Text("Customers"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(AppPages.customerEdit);
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
      body: Column(
        children: [_buildSearchAndFilter(), _buildCustomerList()],
      ),
    );
  }

  _buildCustomerList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final documents = snapshot.data!.docs;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = CustomerModel.fromJson(documents[index]);
                return CustomerTile(model: data);
              });
        });
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
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (String? s) => search,
                    decoration: const InputDecoration(
                        hintText: "Search...", suffixIcon: Icon(Icons.search)),
                  ),
                )),
            Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: const Column(
                      children: [Icon(LineAwesomeIcons.filter), Text("Filter")],
                    )))
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

class CustomerTile extends StatelessWidget {
  final CustomerModel model;

  const CustomerTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppPages.customerDetail, extra: model);
      },
      child: Container(
        padding: EdgeInsets.all(8),
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
                      "${model.firstName}\t${model.lastName}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model.city,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(model.phoneNumber.toString())
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
