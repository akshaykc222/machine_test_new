import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MandatoryText extends StatelessWidget {
  final String title;
  final bool? requiredTxt;
  const MandatoryText({Key? key, required this.title, this.requiredTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              //
              color: AppColors.lightGrey,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        requiredTxt == false
            ? const SizedBox()
            : const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              )
      ],
    );
  }
}
