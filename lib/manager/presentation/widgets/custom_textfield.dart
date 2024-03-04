import 'package:crm_machine_test/manager/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final bool? required;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? widgetLabel;
  final TextInputType? textInputType;
  final bool? enable;
  final bool? showSuffixIcon;
  final Function(String)? validator;
  final bool? passwordField;
  final int? lines;
  final int? maxLength;
  final bool? topBorder;
  final bool? bottomBorder;
  final Function(String)? onChange;
  // final FocusNode focusNode;
  const CustomTextField(
      {Key? key,
      required this.title,
      this.prefix,
      this.required,
      this.suffix,
      this.widgetLabel,
      this.enable,
      this.showSuffixIcon,
      this.controller,
      this.validator,
      this.textInputType,
      this.passwordField,
      this.lines,
      this.maxLength,
      this.onChange,
      this.topBorder,
      this.bottomBorder})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool showPrefixIcon;
  bool showPassword = true;
  @override
  void initState() {
    showPrefixIcon = widget.showSuffixIcon ?? false;
    super.initState();
  }

  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey, width: 0.5),
          borderRadius: widget.topBorder == true
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : widget.bottomBorder == true
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 4.0),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: MandatoryText(
          //       title: widget.title,
          //       requiredTxt: widget.required,
          //     ),
          //   ),
          // ),
          TextFormField(
            style: const TextStyle(fontSize: 20.0, color: AppColors.dartGrey),
            onTap: () {
              setState(() {
                if (!_focusNode.hasFocus) {
                  showPrefixIcon = true;
                } else {
                  showPrefixIcon = true;
                }
              });
            },
            onChanged:
                widget.onChange == null ? null : (val) => widget.onChange!(val),
            maxLength: widget.maxLength,
            controller: widget.controller,
            validator: widget.validator == null
                ? null
                : (val) => widget.validator!(val ?? ""),
            focusNode: _focusNode,
            obscureText: widget.passwordField == true ? showPassword : false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            maxLines: widget.passwordField == true ? 1 : widget.lines,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: const TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                floatingLabelStyle: const TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: showPrefixIcon ? widget.prefix : null,
                suffixIcon: widget.passwordField == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility))
                    : widget.suffix,
                label: widget.widgetLabel ??
                    Text(
                      widget.title,
                      style: const TextStyle(color: Colors.grey),
                    ),
                enabled: widget.enable ?? true),
          ),
        ],
      ),
    );
  }
}
