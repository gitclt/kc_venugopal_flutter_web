import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

Color getBgColor(int index) {
  const evenColor = Colors.white;
  final oddColor = AppColor.grey;
  return index % 2 == 0 ? oddColor : evenColor;
}

String capitalizeLetter(String input) {
  if (input.isEmpty) return input; // Handle empty string
  return input
      .split(' ') // Split string into words
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
      .join(' '); // Capitalize and join back
}

Color priorityColor(String value) {
  if (value == 'High') {
    return Colors.red;
  } else if (value == 'Low') {
    return Colors.green;
  }
  return Colors.grey;
}
