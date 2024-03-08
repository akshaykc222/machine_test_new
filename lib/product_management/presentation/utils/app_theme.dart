import 'package:crm_machine_test/product_management/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get primaryTheme => ThemeData(
      scaffoldBackgroundColor: AppColors.bgColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bgColor),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: AppColors.dartGrey),
        titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.dartGrey),
        bodyMedium: TextStyle(
            color: AppColors.dartGrey,
            fontWeight: FontWeight.w400,
            fontSize: 15),
        bodySmall: TextStyle(
            color: AppColors.dartGrey,
            fontWeight: FontWeight.w300,
            fontSize: 15),
      ).apply(bodyColor: AppColors.dartGrey, displayColor: AppColors.dartGrey),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 18)),
        minimumSize: const MaterialStatePropertyAll(Size(130, 55)),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              // Define the disabled color for the button
              return AppColors.disableButtonColor;
            }
            // Define the enabled color for the button
            return AppColors.enableButtonColor;
          },
        ),
        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        )),
      )),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), focusedBorder: OutlineInputBorder()));
}
