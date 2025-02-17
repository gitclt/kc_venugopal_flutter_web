import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBottomsheet extends StatelessWidget {
    final Function(ImageSource) pickImage;
  const PickImageBottomsheet({super.key, required this.pickImage});

  @override
  Widget build(BuildContext context) {
   return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Scheme Type",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              leading: const Icon(
                Icons.file_copy,
                color: Colors.blue,
              ),
              title: const Text("Gallery"),
              onTap: () {
                pickImage(ImageSource.gallery);
              }),
          // ListTile(
          //   leading: const Icon(
          //     Icons.camera,
          //     color: Colors.green,
          //   ),
          //   title: const Text("Camera"),
          //   onTap: () {
          //     pickImage(ImageSource.camera);
          //   },
          // )
        ],
      ),
    );
  }
}

// shapes
RoundedRectangleBorder bootomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  );
}
