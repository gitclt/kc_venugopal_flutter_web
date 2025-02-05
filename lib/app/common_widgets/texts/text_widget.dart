import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

Text boldText(String label,
    {FontWeight? fontWeight = FontWeight.w600,
    double? fontSize,
    TextAlign? textAlign,
    Color? color = AppColor.blackColor}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: 'Neue Montreal',
        fontSize: fontSize ?? 13,
        color: color),
  );
}

Text xtraBoldText(String label, double fontSize,
    {FontWeight? fontWeight = FontWeight.w800,
    Color? color = AppColor.blackColor}) {
  return Text(
    label,
    style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: 'Neue Montreal',
        fontSize: fontSize,
        color: color),
  );
}

Text columnText(String label, double fontSize,
    {TextAlign? textAlign = TextAlign.center,
    FontWeight? fontWeight = FontWeight.w500,
    Color? color = Colors.black}) {
  return Text(
    label,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: 'Neue Montreal',
        fontSize: fontSize,
        color: color),
  );
}
