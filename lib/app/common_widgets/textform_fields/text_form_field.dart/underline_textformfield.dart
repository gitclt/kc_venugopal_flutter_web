import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnderlineTextFormField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController? textEditingController;
  final FormFieldValidator? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  const UnderlineTextFormField(
      {super.key,
      this.label,
      required this.hint,
      this.textEditingController,
      this.suffixIcon,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}

class CommonTextField extends StatelessWidget {
  final String hintText;
  final bool? isEnable;
  final bool? isRead;
  final bool? inputFormate;
  final bool? isCenterText;
  final bool? interactiveSection;
  final FormFieldValidator? validator;
  final Widget? prefixIcon;
  final String? labelText;
  final String? initialText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final int? maxLengthLimit;
  final TextInputType? textInputType;
  final Function? onTap;
  final bool obscureText;
  final bool isDense;
  final FocusNode? focusNode;
  final double horizotalPadding;
  final TextEditingController? textEditingController;
  final double? fontSize;
  final double borderRadius;
  final Color? fillColor, borderColor;

  const CommonTextField({
    super.key,
    this.isEnable,
    this.isCenterText,
    this.textInputType,
    this.onChanged,
    this.horizotalPadding = 10,
    this.isDense = false,
    this.interactiveSection = true,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.inputFormate,
    this.labelText,
    this.initialText,
    this.maxLengthLimit,
    this.onTap,
    this.obscureText = false,
    this.textEditingController,
    this.borderRadius = 8,
    this.validator,
    this.fontSize,
    this.focusNode,
    this.isRead,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      initialValue: initialText,
      controller: textEditingController,
      enabled: isEnable ?? true,
      readOnly: isRead ?? false,
      focusNode: focusNode,
      inputFormatters: inputFormate == null
          ? null
          : [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxLengthLimit)
            ],
      textAlign: isCenterText == null ? TextAlign.start : TextAlign.center,
      onTap: onTap == null
          ? null
          : () {
              onTap!();
            },
      onChanged: onChanged == null
          ? null
          : (String? value) {
              if (value == null) return;
              onChanged!(value);
            },
      style: TextStyle(fontSize: fontSize ?? 15),
      keyboardType: textInputType ?? TextInputType.text,
      enableInteractiveSelection: interactiveSection,
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.white,
        contentPadding:
            EdgeInsets.symmetric(vertical: 5, horizontal: horizotalPadding),
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
        filled: true,
        isDense: isDense,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? const Color(0xFF939393).withOpacity(0.5),
              width: .5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? const Color(0xFF939393).withOpacity(0.5),
              width: .5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? const Color(0xFF939393).withOpacity(0.5),
              width: .5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
