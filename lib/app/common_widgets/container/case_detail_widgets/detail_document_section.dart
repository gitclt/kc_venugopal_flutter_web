import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_detail_model.dart';

class DetailDocumentSection extends StatelessWidget {
  final RxList<CaseDocument> data;
  final Function(ImageSource?, String?) mediaPicker;
  final Function? onTap;
  const DetailDocumentSection(
      {super.key, required this.data, required this.mediaPicker, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        columnText('Documents', 22),
        if (data.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // 5 columns as per your image
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 130,
              childAspectRatio: 1, // Adjust the width-to-height ratio
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: onTap == null
                    ? null
                    : () {
                        onTap!(index);
                      },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: data[index].documentPath ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Icon(
                          Icons.insert_drive_file,
                          size: 22,
                          color: AppColor.appointTextColor,
                        ),
                        // placeholder: (context, url) =>
                        //     CircularProgressIndicator(),
                      ),
                      5.height,
                      columnText(
                          Uri.parse(data[index].documentPath ?? '')
                              .pathSegments
                              .last,
                          10)
                    ],
                  ),
                ),
              );
            },
          ).paddingOnly(top: 10),
        12.height,
        CommonButton(
            onClick: () {
              Get.bottomSheet(
                PickImageBottomsheet(
                  pickMedia: (ImageSource? imageSource, String? fileType) {
                    mediaPicker(imageSource, fileType);
                    Get.back(); // Close the bottom sheet after selection
                  },
                ),
                elevation: 20.0,
                enableDrag: false,
                isDismissible: true,
                backgroundColor: Colors.white,
                shape: bootomSheetShape(),
              );
            },
            label: '+ Add New Document')
      ],
    ));
  }
}
