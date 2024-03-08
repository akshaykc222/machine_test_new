import 'package:crm_machine_test/product_management/domain/entities/product_entity.dart';
import 'package:crm_machine_test/product_management/presentation/manager/product/qr_code_screen.dart';
import 'package:crm_machine_test/product_management/presentation/pages/auth/auth_mobile.dart';
import 'package:crm_machine_test/product_management/presentation/pages/auth/register.dart';
import 'package:crm_machine_test/product_management/presentation/pages/auth/set_pin.dart';
import 'package:crm_machine_test/product_management/presentation/pages/check_pin.dart';
import 'package:crm_machine_test/product_management/presentation/pages/product/product_detail.dart';
import 'package:crm_machine_test/product_management/presentation/pages/product/product_edit.dart';
import 'package:crm_machine_test/product_management/presentation/pages/product/product_list.dart';
import 'package:crm_machine_test/product_management/presentation/pages/splash_screen.dart';
import 'package:crm_machine_test/product_management/presentation/router/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get routerConfig =>
      GoRouter(initialLocation: AppPages.initial, routes: [
        GoRoute(
            path: AppPages.initial,
            name: AppPages.initial,
            builder: (context, state) {
              return const SplashScreen();
            }),
        GoRoute(
            path: AppPages.checkPin,
            name: AppPages.checkPin,
            builder: (context, state) {
              return const CheckPinScreen();
            }),
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
            path: AppPages.productList,
            name: AppPages.productList,
            builder: (context, state) {
              return const ProductListScreen();
            }),
        GoRoute(
            path: AppPages.productEdit,
            name: AppPages.productEdit,
            builder: (context, state) {
              return const ProductEdit();
            }),
        GoRoute(
            path: AppPages.productDetail,
            name: AppPages.productDetail,
            builder: (context, state) {
              ProductEntity json = state.extra as ProductEntity;
              return ProductDetail(model: json);
            }),
        GoRoute(
            path: AppPages.setPin,
            name: AppPages.setPin,
            builder: (context, state) {
              return const SetPinScreen();
            }),
        GoRoute(
            path: AppPages.qr,
            name: AppPages.qr,
            builder: (context, state) {
              return const QrCodeReader();
            }),
      ]);
}
