import 'package:flutter/material.dart';

const spacer10 = SizedBox(
  height: 10,
);
const spacer5 = SizedBox(
  height: 5,
);

const spacer25 = SizedBox(
  height: 25,
);
const spacer20 = SizedBox(
  height: 20,
);
const spacer50 = SizedBox(
  height: 50,
);
bool isEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return emailRegex.hasMatch(email);
}

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
