import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_detail_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';

class ProgramScheduleDetailController extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  RxString error = ''.obs;
  final isStatusLoading = false.obs;
  final isLoading = false.obs;

  DropDownModel detailStatusDrop = DropDownModel();
  final TextEditingController remarkController = TextEditingController();

  RxList<CaseDetailData> dataDetail = <CaseDetailData>[].obs;
  RxList<CaseDocument> detailDocument = <CaseDocument>[].obs;
  RxList<CaseStatus> detailStatus = <CaseStatus>[].obs;
  RxList<ContactPersonDetail> detailContactPerson = <ContactPersonDetail>[].obs;

  final repo = CasesRepository();

  @override
  void onInit() {
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
   //   id: programId,
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

  void addDocument() async {
    isLoading(true);
    final res = await repo.addDocument(
        accountId: LocalStorageKey.userData.accountId,
        type: ConstValues.typeProgram,
        // document: imageName.value,
        // caseId: addNew != '' ? programId : caseId,
        // imageData: encodedData,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
        // if (addNew != '') {
        //   getProgramDetail();
        // }
      }
    });
  }

  void updateStatus() async {
    isStatusLoading(true);
    final res = await repo.updateStatus(
     // id: programId,
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
        // addNew = '';
        // getProgramSchedules();
        // Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
      }
    });
  }
}
