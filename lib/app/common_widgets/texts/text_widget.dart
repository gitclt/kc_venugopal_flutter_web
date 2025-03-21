import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:sizer/sizer.dart';

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
        fontSize: fontSize ?? 13.sp,
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

Text subTitleText(String label,
    {TextAlign? textAlign = TextAlign.center,
    double? fontSize,
    FontWeight? fontWeight = FontWeight.w400,
    Color? color = AppColor.subTitleColor}) {
  return Text(
    label,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: 'Neue Montreal',
        fontSize: fontSize ?? 11.sp,
        color: color),
  );
}

Text columnHeaderText(String label,
    {TextAlign? textAlign = TextAlign.center,
    double? fontSize,
    FontWeight? fontWeight = FontWeight.w400,
    Color? color = AppColor.columnHeadColor}) {
  return Text(
    label,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: fontWeight,
        fontFamily: 'Plus Jakarta Sans',
        fontSize: fontSize ?? 10.2.sp,
        color: color),
  );
}
