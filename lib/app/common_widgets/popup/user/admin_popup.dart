import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/common_circle_container.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class AdminPopUp extends StatelessWidget {
  final Function(String) onSelected;
  const AdminPopUp({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shadowColor: Colors.black,
      //  backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.white),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.45,
              maxHeight: MediaQuery.of(context).size.width * 0.40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: circleContainer()),
              ),
              Center(
                child: Column(
                  children: [
                    circleContainer(
                        icon: Icons.person_outline,
                        size: 40.0,
                        iconColor: AppColor.primary,
                        bgColor: AppColor.secondaryBackground),
                    Text(
                      'admin'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuItem(
                      context, 'profile'.tr, Icons.person, onSelected),
                  _buildMenuItem(
                      context, 'change_password'.tr, Icons.lock, onSelected),
                  _buildMenuItem(
                      context, 'logout'.tr, Icons.exit_to_app, onSelected),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String value, IconData icon,
      void Function(String) onSelected) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            color: AppColor.grey.withOpacity(.5)),
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSelected(value);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: AppColor.primary,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            )),
      ),
    );
  }
}
