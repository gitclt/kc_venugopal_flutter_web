import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class SidemenuWidget extends StatelessWidget {
  final IconData? iconData;
  final String? svgIcon;
  final String label;
  final bool isSelected;
  final Function onClick;
  const SidemenuWidget(
      {super.key,
      this.iconData,
      this.isSelected = false,
      this.svgIcon = '',
      required this.label,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        //dense: false,
        selected: isSelected,
        tileColor: AppColor.primary,
        minVerticalPadding: 0,
        onTap: () {
          onClick();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),

        //selectedColor: AppColor.primaryColor,
        leading: iconData != null
            ? Icon(
                iconData,
                size: 25,
                color: !isSelected ? Colors.white : AppColor.textGrayColor,
              )
            : svgIcon != ''
                ? svgWidget(svgIcon!,
                    color: !isSelected ? Colors.white : AppColor.textGrayColor,
                    size: 24)
                : const SizedBox(),
        title: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: !isSelected ? Colors.white : AppColor.textGrayColor,
              fontSize: 14),
        )).paddingOnly(left: 0);
  }
}

class ExpandedTileWidget extends StatefulWidget {
  final String label;
  final List<Widget> children;
  final bool isSelected;
  final IconData icon;
  const ExpandedTileWidget(
      {super.key,
      required this.label,
      required this.icon,
      required this.children,
      this.isSelected = false});

  @override
  State<ExpandedTileWidget> createState() => _ExpandedTileWidgetState();
}

class _ExpandedTileWidgetState extends State<ExpandedTileWidget> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        isExpand = value;
        setState(() {});
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: widget.isSelected ? AppColor.peal : null,
      collapsedIconColor: AppColor.grey,
      collapsedBackgroundColor: AppColor.grey,
      collapsedTextColor: AppColor.grey,
      iconColor: widget.isSelected ? AppColor.white : null,
      textColor: widget.isSelected ? AppColor.white : AppColor.grey,
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      leading: Icon(
        widget.icon,
        //  color: isSelected ? AppColor.whiteColor : null,
      ),
      trailing: Icon(
        isExpand ? Icons.keyboard_arrow_down : Icons.add,
        //color: isSelected ? AppColor.whiteColor : AppColor.sideTextColor,
      ),
      title: Text(
        widget.label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      children: widget.children,
    );
  }
}
