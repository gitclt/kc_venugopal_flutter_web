import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/category_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/priority_repository.dart';

class SupportRequestController extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  final isDropLoading = false.obs;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  DropDownModel statusFilter = DropDownModel();
  DropDownModel categoryFilter = DropDownModel();
  DropDownModel priorityFilter = DropDownModel();
  RxList<DropDownModel> statusDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> categoryDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> priorityDropList = <DropDownModel>[].obs;

  RxList<CasesData> data = <CasesData>[].obs;
  RxList<CasesData> dataCopy = <CasesData>[].obs;
  final repo = CasesRepository();
  final catRepo = CategoryRepository();
  final priorRepo = PriorityRepository();
  var pageIndex = 1.obs;
  var pageSize = 10.obs;
  var totalCount = 1.obs;

  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDropDownValues();
    getSupportRequests();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  @override
  void dispose() {
    super.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    keywordController.dispose();
  }

  void getCategory() async {
    isDropLoading(true);
    categoryDropList.clear();
    categoryDropList.add(DropDownModel(id: '', name: '--Select Category--'));
    final res = await catRepo
        .getCategory(LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      isDropLoading(false);

      setError(error.toString());
    }, (resData) {
      isDropLoading(false);

      for (var t in resData.data!) {
        categoryDropList.add(DropDownModel(id: t.id.toString(), name: t.name));
      }
    });
  }

  void getPriority() async {
    isDropLoading(true);
    priorityDropList.clear();
    priorityDropList.add(DropDownModel(id: '', name: '--Select Priority--'));
    final res = await priorRepo
        .getPriority(LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      isDropLoading(false);

      setError(error.toString());
    }, (resData) {
      isDropLoading(false);

      for (var t in resData.data!) {
        priorityDropList.add(DropDownModel(id: t.id.toString(), name: t.name));
      }
    });
  }

  void getDropDownValues() {
    for (var v in ConstValues().status) {
      statusDropList.add(DropDownModel(id: v.id.toString(), name: v.name));
    }
    getCategory();
    getPriority();
  }

  void getSupportRequests() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: pageSize.value == 0 ? '0' : pageIndex.value.toString(),
        pageSize: pageSize.value == 0 ? '0' : pageSize.value.toString(),
        type: ConstValues.typeSupport,
        fromDate: fromDateController.text.trim(),
        toDate: toDateController.text.trim(),
        status: statusFilter.name ?? '',
        categoryId: categoryFilter.id ?? '',
        priorityId: priorityFilter.id ?? '',
        keyword: keywordController.text.trim());
    response.fold((failure) {
      setRxRequestStatus(Status.completed);
      setError(error.toString());
    }, (resData) {
      setRxRequestStatus(Status.completed);
      if (pageSize.value != 0) {
        totalCount.value =
            (int.parse(resData.totalCount!) / pageSize.value).ceil();
      }
      if (resData.data != null) {
        data.addAll(resData.data!);
        dataCopy.addAll(resData.data!);
      }
    });
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getSupportRequests(); // Fetch the employee list for the new page
    }
  }
}
