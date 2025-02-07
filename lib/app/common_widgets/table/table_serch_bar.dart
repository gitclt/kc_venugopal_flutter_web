import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/underline_textformfield.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';


// ignore: must_be_immutable
class TableSerchBar extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final VoidCallback? onTapExcelDown;
  final bool? showExcel;
  final String? tooltip;
  final bool? visible;
  late String? pageValue;
  final Function(String)? onChanged;
  TableSerchBar({
    super.key,
    required this.size,
    this.onSearchChanged,
    this.onTapExcelDown,
    this.visible = false,
    this.pageValue,
    this.onChanged,
    this.showExcel = false,
    this.tooltip,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (visible == true)
          Row(
            children: [
              const Text("Show : ",
                  style: TextStyle(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColor.textGrayColor,
                    ),
                  ),
                  height: size.height * 0.035,
                  width: size.width * 0.06,
                  child: DropdownButton<String>(
                    value: pageValue,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    underline: const SizedBox(),
                    isDense: true,
                    // hint: const Text(
                    //   "10",
                    // ),
                    isExpanded: true,
                    items: <String>['10', '50', '100','All'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      onChanged!(value!);
                    },
                  )),
              const Text("Entries",
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w400,
                          fontSize: 12))
                  .paddingOnly(left: 5),
            ],
          ),
        const Spacer(),
        if (showExcel == true)
          Tooltip(
            message: tooltip ?? '',
            child: SmallIconButton(
              toolmessage: 'Download Excel',
              iconData: Icons.download,
              color: Colors.green,
              onTap: onTapExcelDown,
            ),
          ),
        if (showExcel == true) 12.width,
        const Text("Search : ",
            style: TextStyle(
                color: Color.fromARGB(255, 103, 86, 86),
                fontWeight: FontWeight.w400,
                fontSize: 12)),
        SizedBox(
            height: size.height * 0.045,
            width: size.width * 0.125,
            child: CommonTextField(
              hintText: "",
              borderRadius: 5,
              onChanged: onSearchChanged,
            ))
      ],
    );
  }
}
