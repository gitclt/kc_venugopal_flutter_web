import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.borderRadius = 8.0,
    this.fillColor,
    this.hintText,
    this.onTap,
    this.labelText,
    this.height,
    this.width,
    this.minLines,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text(
                  label!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (visible == true)
                  const Text("*", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        SizedBox(
          width: width ?? size.width * 0.8,
          // height: height ?? 50,
          child: TextFormField(
            controller: textController,
            validator: validator,
            readOnly: readonly!,
            onTap: onTap as void Function()?,
            onChanged: onChanged as void Function(String)?,
            style: TextStyle(fontSize: fontSize ?? 14, color: Colors.black87),
            inputFormatters: inputFormat == true
                ? [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]*\.?[0-9]*')),
                    LengthLimitingTextInputFormatter(maxLengthLimit),
                  ]
                : null,
            keyboardType: keyboard ?? TextInputType.text,
            minLines: obscureText ? 1 : minLines,
            maxLines: obscureText ? 1 : minLines ?? 1,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.grey[100],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
