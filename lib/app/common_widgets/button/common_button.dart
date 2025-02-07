import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';


class CommonButton extends StatelessWidget {
  final Function onClick;
  final String label;
  final bool isLoading;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? bgColor;
  const CommonButton({
    super.key,
    required this.onClick,
    required this.label,
    this.isLoading = false,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius = 5.0,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                onClick();
              },
        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            elevation: 2.0,
            textStyle: const TextStyle(color: Colors.white)),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    label,
                  )),
      ),
    );

    // return InkWell(
    //   onTap: isLoading
    //       ? null
    //       : () {
    //           onClick();
    //         },
    //   child: Container(
    //     width: width ?? MediaQuery.of(context).size.width,
    //     height: height ?? MediaQuery.of(context).size.height * 0.06,
    //     decoration: BoxDecoration(
    //         color: AppColor.primaryColor,
    //         borderRadius: BorderRadius.circular(5)),
    //     child: Center(
    //         child: isLoading
    //             ? const CircularProgressIndicator(
    //                 color: Colors.white,
    //               )
    //             : whiteText(label, fontSize: fontSize)),
    //   ),
    // );
  }
}

class SmallIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color? color;
  final double size;
  final String toolmessage;
  const SmallIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.size = 20,
    required this.toolmessage,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.greyColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: svgWidget(icon, size: size)),
      ),
    );
  }
}

class CommonOutlinedButton extends StatelessWidget {
  const CommonOutlinedButton({
    super.key,
    required this.lable,
    required this.act,
  });
  final String lable;
  final VoidCallback act;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: act,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColor.primary, width: 1.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        lable,
        style: TextStyle(color: AppColor.primary, fontSize: 14),
      ),
    );
  }
}

class CommonIconButton extends StatelessWidget {
  final Function onClick;
  final String label;
  final bool isLoading;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? bgColor;
  const CommonIconButton({
    super.key,
    required this.onClick,
    required this.label,
    this.isLoading = false,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius = 5.0,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                onClick();
              },
        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            elevation: 2.0,
            textStyle: const TextStyle(color: Colors.white)),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    children: [
                      const Icon(Icons.shopping_cart),
                      5.width,
                      Text(
                        label,
                      ),
                    ],
                  )),
      ),
    );
  }
}
