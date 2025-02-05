import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';


class AddTextFieldWidget extends StatelessWidget {
  final String? label;
  final TextEditingController? textController;
  final FormFieldValidator? validator;
  final Function? onChanged;
  final double? fontSize;
  final double borderRadius;
  final double? height;
  final Color? fillColor;
  final Widget? suffixIcon;
  final TextInputType? keyboard;
  final bool? inputFormat;
  final int? maxLengthLimit;
  final String? hintText;
  final Function? onTap;
  final String? labelText;
  final bool? visible;
  final bool? readonly;
  final bool obscureText;
  final double? width;

  final int? minLines;

  const AddTextFieldWidget({
    super.key,
    this.label,
    this.textController,
    this.validator,
    this.suffixIcon,
    this.readonly = false,
    this.keyboard,
    this.inputFormat,
    this.maxLengthLimit,
    this.visible = false,
    this.onChanged,
    this.fontSize,
    this.borderRadius = 5,
    this.fillColor,
    this.hintText,
    this.onTap,
    this.labelText,
    this.height,
    this.width,
    this.minLines,
    this.obscureText = false,
    // this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (label != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label!,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColor.textGrayColor),
            ),
            if (visible == true)
              Text(
                "*",
                style: TextStyle(color: AppColor.primary),
              ).paddingOnly(left: 3),
          ],
        ),
      SizedBox(
          width: Responsive.isDesktop(context)
              ? width ?? size.width * 0.73 / 2
              : size.width * .8,
          height: height ?? size.height * 0.066,
          child: TextFormField(
            //  initialValue: initialValue,
            controller: textController,
            validator: validator,
            readOnly: readonly!,
            onTap: onTap == null
                ? null
                : () {
                    onTap!();
                  },
            onChanged: onChanged == null
                ? null
                : (String? value) {
                    onChanged!(value);
                  },
            style: TextStyle(fontSize: fontSize ?? 12),
            inputFormatters: inputFormat == null
                ? null
                : [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    LengthLimitingTextInputFormatter(maxLengthLimit)
                  ],
            keyboardType: keyboard ?? TextInputType.text,
            minLines: obscureText
                ? 1
                : minLines, // Ensure single line when obscureText is true
            maxLines: obscureText ? 1 : minLines,
            obscureText: obscureText,
            decoration: InputDecoration(
                fillColor: fillColor ?? Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                hintStyle: const TextStyle(
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                ),
                labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColor.textGrayColor, width: .5),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColor.textGrayColor, width: .5),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColor.textGrayColor, width: .5),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                hintText: hintText,
                labelText: labelText,
                suffixIcon: suffixIcon),
          ).paddingOnly(top: 10))
    ]);
  }
}
