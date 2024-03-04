import 'package:crm_machine_test/manager/data/models/customer_model.dart';
import 'package:crm_machine_test/manager/presentation/pages/auth/auth_mobile.dart';
import 'package:crm_machine_test/manager/presentation/pages/auth/register.dart';
import 'package:crm_machine_test/manager/presentation/pages/customer/customer_detail.dart';
import 'package:crm_machine_test/manager/presentation/pages/customer/customer_edit.dart';
import 'package:crm_machine_test/manager/presentation/pages/dashboard/dashboard.dart';
import 'package:crm_machine_test/manager/presentation/router/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get routerConfig =>
      GoRouter(initialLocation: AppPages.auth, routes: [
        GoRoute(
            path: AppPages.auth,
            name: AppPages.auth,
            builder: (context, state) {
              return const AuthMobile();
            }),
        GoRoute(
            path: AppPages.register,
            name: AppPages.register,
            builder: (context, state) {
              return const RegisterScreen();
            }),
        GoRoute(
            path: AppPages.dashboard,
            name: AppPages.dashboard,
            builder: (context, state) {
              return const DashBoard();
            }),
        GoRoute(
            path: AppPages.customerEdit,
            name: AppPages.customerEdit,
            builder: (context, state) {
              if (state.extra != null) {
                return CustomerEdit(model: state.extra as CustomerModel?);
              }
              return const CustomerEdit();
            }),
        GoRoute(
            path: AppPages.customerDetail,
            name: AppPages.customerDetail,
            builder: (context, state) {
              CustomerModel json = state.extra as CustomerModel;
              return CustomerDetail(model: json);
            }),
      ]);
}
