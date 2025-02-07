import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class DataGridContainer extends StatelessWidget {
  final String dataCell;
  final Color? bgColor;
  const DataGridContainer({super.key, required this.dataCell, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColor.grey, width: 1.0),
            )),
        // alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: columnText(dataCell, 12));
  }
}

class DataGridIconContainer extends StatelessWidget {
  final Widget? dataCell;
  final Color? bgColor;

  const DataGridIconContainer({super.key, this.dataCell, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColor.grey, width: 1.0),
            )),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: dataCell);
  }
}

class DataGridTotalContainer extends StatelessWidget {
  final String dataCell;
  final Color? bgColor;
  const DataGridTotalContainer(
      {super.key, required this.dataCell, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: AppColor.grey.withOpacity(.2),
            border: Border(
          bottom: BorderSide(color: AppColor.grey, width: 1.0),
        )),
        child: columnText(dataCell, 14));
  }
}
