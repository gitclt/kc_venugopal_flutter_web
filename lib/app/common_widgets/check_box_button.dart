import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class CheckBoxButton extends StatelessWidget {
  final bool selectItem;
  final Function act;
  const CheckBoxButton(
      {super.key, required this.selectItem, required this.act});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
          onTap: () {
            act();
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.012,
            width: MediaQuery.of(context).size.width * 0.012,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                width: 1.5,
                color: selectItem ? AppColor.primary : AppColor.tabTextColor,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectItem ? AppColor.primary : Colors.transparent,
              ),
              child: selectItem
                  ? const Icon(
                      Icons.check_sharp,
                      color: Colors.white,
                      size: 12,
                    )
                  : const Icon(null),
            ),
          )),
    ]);
  }
}
