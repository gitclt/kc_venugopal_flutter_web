import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';


Container circleContainer(
    {IconData? icon, double? size, Color? iconColor, Color? bgColor}) {
  return Container(
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: bgColor ?? const Color(0xFFEFF2F5)),
      child: Center(
        child: Icon(
          icon ?? Icons.close,
          size: size ?? 15,
          color: iconColor ?? Colors.black,
        ),
      ));
}

Container circleSvgContainer(String imgPath, {double? size, Color? color}) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 12,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: svgWidget(imgPath, size: size, color: color));
}
