import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

DateTime? _selectedDate;
DateTime? _selectedToDate;


Future<void> selectDate(
    BuildContext context, TextEditingController textController) async {
  _selectedDate = null;
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.primary, // Header background color
            onPrimary: Colors.white, // Header text color
            onSurface: Colors.black, // Body text color
          ),
          //dialogBackgroundColor: AppColor.primary, // Background color
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    _selectedDate = picked;

    textController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }
}

Future<void> selectToDate(
    BuildContext context, TextEditingController textController) async {
  _selectedToDate = null;
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedToDate ?? DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.primary, // Header background color
            onPrimary: Colors.white, // Header text color
            onSurface: Colors.black, // Body text color
          ),
          //dialogBackgroundColor: AppColor.primary, // Background color
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    _selectedToDate = picked;
    // if (date == 'joinDate') {
    textController.text = DateFormat('yyyy-MM-dd').format(_selectedToDate!);
    // }
  }
}

TimeOfDay? selectedTime;

Future<void> selectTime(
    BuildContext context, TextEditingController textController) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime ?? TimeOfDay.now(),
  );
  if (picked != null && picked != selectedTime) {
    selectedTime = picked;

    textController.text =
        "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}";
  }
}
