import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// First, let's modify the callback to handle both image picker and file picker
class PickImageBottomsheet extends StatelessWidget {
  // Update the callback signature to handle both image source and file type
  final Function(ImageSource?, String?) pickMedia;
  
  const PickImageBottomsheet({super.key, required this.pickMedia});
  
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
                "Select File Type",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close)
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.image,
              color: Colors.blue,
            ),
            title: const Text("Gallery"),
            onTap: () {
              // Pass the image source, null for fileType
              pickMedia(ImageSource.gallery, null);
            }
          ),
          ListTile(
            leading: const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
            title: const Text("Documents"),
            onTap: () {
              // Pass null for image source, 'pdf' for fileType
              pickMedia(null, 'pdf');
            }
          ),
         
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
