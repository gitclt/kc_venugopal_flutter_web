import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';

class DropDown3Widget extends StatelessWidget {
  final List<DropDownModel> items;
  final DropDownModel? selectedItem;
  final String? label;
  final double? width;
  final Function(DropDownModel?)? onChanged;
  final bool isLoading;
  final bool isEnabled;
  final String? hint;
  final bool? visible;
  final bool isSearchEnable;
  final FormFieldValidator? validator;
  final bool? isAddButton;

  const DropDown3Widget({
    super.key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.label,
    this.width,
    this.isLoading = false,
    this.isEnabled = true,
    this.hint,
    this.visible = false,
    this.validator,
    this.isAddButton = false,
    this.isSearchEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColor.textGrayColor, width: 0.5),
    );
    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 159, 158, 158).withOpacity(0.3),
      ),
    );
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.textGrayColor,
                ),
              ),
              Visibility(
                  visible: visible!,
                  child: Text(
                    '*',
                    style: TextStyle(color: AppColor.primary),
                  )).paddingOnly(left: 5)
            ],
          ),
        if (label != null) const SizedBox(height: 10),
        Flexible(
          child: SizedBox(
            //  height: size.height * 0.058,
            child: Stack(
              children: [
                Container(
                  width: Responsive.isDesktop(context)
                      ? width ?? size.width * 0.73 / 2
                      : size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: isEnabled ? null : () {},
                    child: AbsorbPointer(
                      absorbing: !isEnabled,
                      child: DropdownSearch<DropDownModel>(
                        validator: validator,
                        compareFn: (item, selectedItem) =>
                            item.id == selectedItem.id,
                        popupProps: PopupProps.menu(
                          scrollbarProps:
                              const ScrollbarProps(thumbVisibility: true),
                          showSearchBox: isSearchEnable,
                          searchDelay: Duration.zero,
                          searchFieldProps: TextFieldProps(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: isEnabled == true
                                ? const InputDecoration(
                                    labelText: "Search",
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    border: OutlineInputBorder(),
                                  )
                                : const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                          ),
                          itemBuilder:
                              (context, selectedItem, item, isSelected) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                item.toString(), // Customize as per your item's display string

                                style: const TextStyle(
                                    fontSize: 11), // Decrease font size here
                              ),
                            );
                          },
                        ),
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            filled: true,
                            isDense: true,
                            fillColor: isEnabled
                                ? AppColor.white
                                : const Color.fromARGB(255, 246, 244, 244)
                                    .withOpacity(0.3),
                            hintText: hint,
                            hintStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis, fontSize: 11),
                            border: isEnabled ? enabledBorder : disabledBorder,
                            errorBorder:
                                isEnabled ? enabledBorder : disabledBorder,
                            focusedBorder: isEnabled
                                ? outlineFocusedInputBorder2
                                : disabledBorder,
                            enabledBorder:
                                isEnabled ? enabledBorder : disabledBorder,
                          ),
                        ),
                        items: (filter, infiniteScrollPops) => items,
                        selectedItem: selectedItem,
                        dropdownBuilder: (context, selectItem) {
                          return Text(
                            selectItem?.toString() ?? hint!,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis, fontSize: 12),
                            maxLines: 1, // Limits text to one line
                            softWrap: false, // Prevents wrapping to a new line
                          );
                        },
                        onChanged: isEnabled ? onChanged : null,
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        width: 24,
                        height: 24,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

var outlineInputBorder2 = OutlineInputBorder(
  borderSide: const BorderSide(color: AppColor.textGrayColor, width: .5),
  borderRadius: BorderRadius.circular(10),
);
var outlineFocusedInputBorder2 = OutlineInputBorder(
  borderSide: BorderSide(color: AppColor.profileButtonLabel, width: .5),
  borderRadius: BorderRadius.circular(10),
);
