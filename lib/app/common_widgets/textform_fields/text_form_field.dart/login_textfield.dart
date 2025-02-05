import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class LoginTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController? textEditingController;
  final FormFieldValidator? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  const LoginTextField(
      {super.key,
      // required this.controller,
      this.label,
      required this.hint,
      this.textEditingController,
      this.suffixIcon,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null)
              Text(
                label!,
                style: const TextStyle(color: Colors.black),
              ),
            Text(
              "*",
              style: TextStyle(color: AppColor.primary),
            ).paddingOnly(left: 3),
          ],
        ),
        hintText: 'Enter $label',
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0xFFDDDDDD),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0xFFDDDDDD),
            width: 1,
          ),
        ),
      ),
    );
  }
}
