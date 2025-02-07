import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

Color getBgColor(int index) {
  const evenColor = Colors.white;
  final oddColor = AppColor.grey;
  return index % 2 == 0 ? oddColor : evenColor;
}