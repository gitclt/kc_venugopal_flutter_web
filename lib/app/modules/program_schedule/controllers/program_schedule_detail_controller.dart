import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_detail_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_controller.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

class ProgramScheduleDetailController extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  RxString error = ''.obs;
  final isStatusLoading = false.obs;
  final isLoading = false.obs;

  DropDownModel detailStatusDrop = DropDownModel();
  final TextEditingController remarkController = TextEditingController();
  RxList<DropDownModel> statusDropList = <DropDownModel>[].obs;
  RxList<CaseDetailData> dataDetail = <CaseDetailData>[].obs;
  RxList<CaseDocument> detailDocument = <CaseDocument>[].obs;
  RxList<CaseStatus> detailStatus = <CaseStatus>[].obs;
  RxList<ContactPersonDetail> detailContactPerson = <ContactPersonDetail>[].obs;
  final ProgramScheduleController programController = Get.find();
  final repo = CasesRepository();
  var id = '';

  @override
  void onInit() {
    for (var v in ConstValues().status) {
      statusDropList.add(DropDownModel(id: v.id.toString(), name: v.name));
    }
    if (Get.rootDelegate.arguments() != null) {
      var args = Get.rootDelegate.arguments();
      id = args['id'] ?? '';
      print(id);
    }
    getProgramDetail();
    super.onInit();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void getProgramDetail() async {
    setRxRequestStatus(Status.loading);
    dataDetail.clear();
    detailStatus.clear();
    detailContactPerson.clear();
    detailDocument.clear();
    //  addNew = '';
    final response = await repo.getCaseDetails(
      accountId: LocalStorageKey.userData.accountId.toString(),
      id: id,
      type: ConstValues.typeProgram,
    );
    response.fold((failure) {
      setRxRequestStatus(Status.completed);
      setError(error.toString());
    }, (resData) {
      setRxRequestStatus(Status.completed);

      if (resData.data != null) {
        dataDetail.addAll(resData.data!);
        if (resData.data!.first.caseStatus!.isNotEmpty) {
          detailStatus.addAll(resData.data!.first.caseStatus!);
        }
        if (resData.data!.first.contactPerson!.isNotEmpty) {
          detailContactPerson.addAll(resData.data!.first.contactPerson!);
        }
        if (resData.data!.first.caseDocuments!.isNotEmpty) {
          detailDocument.addAll(resData.data!.first.caseDocuments!);
        }
      }
    });
  }

  RxString imageName = ''.obs; // Observable for the file name
  Uint8List? pickedFileBytes; // For file bytes
  String? encodedData;
  Future<void> pickImage(
      ImageSource? imageSource, String type, String value) async {
    if (imageSource != null) {
      final ImagePicker picker = ImagePicker();
// Pick an image.

      final XFile? image = await picker.pickImage(source: imageSource);
      // Set the image name and encode data to Base64
      if (image != null) {
        String dateFormat = getFormattedTimestamp();
        if (value == 'add document') {
          imageName.value = "$dateFormat.${image.name.split('.').last}";

          pickedFileBytes = await image.readAsBytes();
          encodedData = base64Encode(pickedFileBytes!);
          addDocument();
        }
      } else {
        imageName.value = '';
      }
    } else if (type == 'pdf') {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String dateFormat = getFormattedTimestamp();
        if (value == 'add document') {
          imageName.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;

          encodedData = base64Encode(pickedFileBytes!);
          addDocument();
        }
      } else {
        imageName.value = '';
      }
    }
  }

  void addDocument() async {
    isLoading(true);
    final res = await repo.addDocument(
        accountId: LocalStorageKey.userData.accountId,
        type: ConstValues.typeProgram,
        document: imageName.value,
        caseId: id,
        imageData: encodedData,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
        getProgramDetail();
      }
    });
  }

  void updateStatus() async {
    isStatusLoading(true);
    final res = await repo.updateStatus(
      id: id,
      type: ConstValues.typeProgram,
      status: detailStatusDrop.name ?? '',
      accountId: LocalStorageKey.userData.accountId.toString(),
      remark: remarkController.text.trim(),
      createdUserId: LocalStorageKey.userData.id.toString(),
    );
    res.fold((failure) {
      isStatusLoading(false);
      setError(error.toString());
    }, (resData) {
      isStatusLoading(false);
      if (resData.status!) {
        remarkController.clear();
        detailStatusDrop = DropDownModel();
        programController.getProgramSchedules();
        Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
      }
    });
  }
}
