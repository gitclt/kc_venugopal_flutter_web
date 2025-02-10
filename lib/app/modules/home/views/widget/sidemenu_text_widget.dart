import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class SidemenuWidget extends StatelessWidget {
  final IconData? iconData;
  final String? svgIcon;
  final String label;
  final bool isSelected;
  final Function onClick;

  const SidemenuWidget({
    super.key,
    this.iconData,
    this.isSelected = false,
    this.svgIcon = '',
    required this.label,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: !isSelected
              ? Colors.white
              : Colors.transparent, // Background for selected item
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  if (iconData != null)
                    Icon(
                      iconData,
                      size: 25,
                      color: !isSelected
                          ? AppColor.primary
                          : AppColor.textGrayColor,
                    ),
                  if (svgIcon != '')
                    svgWidget(
                      svgIcon!,
                      color: !isSelected
                          ? AppColor.primary
                          : AppColor.textGrayColor,
                      size: 24,
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: !isSelected
                            ? AppColor.primary
                            : AppColor.textGrayColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isSelected)
              Positioned(
                right: 0,
                top: 8,
                bottom: 8,
                child: Container(
                  width: 4, // Side indicator thickness
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ExpandedTileWidget extends StatefulWidget {
  final String label;
  final List<Widget> children;
  final bool isSelected;
  final String? svgIcon;
  final IconData? iconData;

  const ExpandedTileWidget({
    super.key,
    required this.label,
    this.iconData,
    required this.children,
    this.isSelected = false,
    this.svgIcon,
  });

  @override
  State<ExpandedTileWidget> createState() => _ExpandedTileWidgetState();
}

class _ExpandedTileWidgetState extends State<ExpandedTileWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: AppColor.textGrayColor),
            bottom: BorderSide(color: AppColor.textGrayColor)),
        color: !widget.isSelected ? Colors.white : Colors.transparent,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ExpansionTile(
            onExpansionChanged: (value) {
              isExpand = value;
              setState(() {});
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            collapsedIconColor:
                !widget.isSelected ? AppColor.primary : AppColor.textGrayColor,
            iconColor:
                !widget.isSelected ? AppColor.primary : AppColor.textGrayColor,
            leading: widget.iconData != null
                ? Icon(
                    widget.iconData,
                    size: 25,
                    color: !widget.isSelected
                        ? AppColor.primary
                        : AppColor.textGrayColor,
                  )
                : widget.svgIcon != ''
                    ? svgWidget(
                        widget.svgIcon!,
                        color: !widget.isSelected
                            ? AppColor.primary
                            : AppColor.textGrayColor,
                        size: 24,
                      )
                    : const SizedBox(),
            trailing: Icon(
              isExpand ? Icons.keyboard_arrow_down : Icons.add,
            ),
            title: Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: !widget.isSelected
                    ? AppColor.primary
                    : AppColor.textGrayColor,
                fontSize: 14,
              ),
            ),
            children: widget.children,
          ),
          if (!widget.isSelected)
            Positioned(
              right: 0,
              top: 8,
              bottom: 8,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
