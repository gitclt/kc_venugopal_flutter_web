import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/add_person_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/assembly_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/category_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/priority_repository.dart';

class ProgramScheduleController extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  final isDropLoading = false.obs;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  //add
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController desigController = TextEditingController();
  final TextEditingController remindDateController = TextEditingController();

  DropDownModel statusFilter = DropDownModel();
  DropDownModel categoryFilter = DropDownModel();
  DropDownModel priorityFilter = DropDownModel();
  DropDownModel addAssemblyDrop = DropDownModel();
  DropDownModel addCategoryDrop = DropDownModel();
  DropDownModel addPriorityDrop = DropDownModel();
  RxList<DropDownModel> statusDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> categoryDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> priorityDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> assemblyDropList = <DropDownModel>[].obs;

  RxList<CasesData> data = <CasesData>[].obs;
  RxList<CasesData> dataCopy = <CasesData>[].obs;
  final repo = CasesRepository();
  final catRepo = CategoryRepository();
  final priorRepo = PriorityRepository();
  final assemblyRepo = AssemblyRepository();
  var pageIndex = 1.obs;
  var pageSize = 10.obs;
  var totalCount = 1.obs;
  RxString error = ''.obs;
  var isReminder = false.obs;

  var persons = <AddPersonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDropDownValues();
    getProgramSchedules();
  }

  @override
  void dispose() {
    super.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    keywordController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void getAssembly() async {
    isDropLoading(true);
    assemblyDropList.clear();
    assemblyDropList.add(DropDownModel(id: '', name: '--Select Assembly--'));
    final res = await assemblyRepo
        .getAssembly(LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      isDropLoading(false);
      setError(error.toString());
    }, (resData) {
      isDropLoading(false);
      for (var t in resData.data!) {
        assemblyDropList.add(DropDownModel(id: t.id.toString(), name: t.name));
      }
    });
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
    addPersons();
  }

  void addPersons() {
    persons.add(AddPersonModel(
        name: TextEditingController(),
        mobile: TextEditingController(),
        designation: TextEditingController()));
  }

  void getProgramSchedules() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: pageSize.value == 0 ? '0' : pageIndex.value.toString(),
        pageSize: pageSize.value == 0 ? '0' : pageSize.value.toString(),
        type: ConstValues.typeProgram,
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
      if (resData.data != null) {
        data.addAll(resData.data!);
        dataCopy.addAll(resData.data!);
      }
    });
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getProgramSchedules(); // Fetch the employee list for the new page
    }
  }
}
