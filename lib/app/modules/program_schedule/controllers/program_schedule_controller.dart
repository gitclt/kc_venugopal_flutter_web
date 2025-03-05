import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/add_person_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_detail_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/assembly_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/category_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/priority_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

class ProgramScheduleController extends GetxController {
  final rxRequestStatus = Status.completed.obs;
  final isDropLoading = false.obs;
  final isLoading = false.obs;
  final isStatusLoading = false.obs;
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
  final TextEditingController uploadController = TextEditingController();

  final TextEditingController remarkController = TextEditingController();

  DropDownModel statusFilter = DropDownModel();
  DropDownModel categoryFilter = DropDownModel();
  DropDownModel priorityFilter = DropDownModel();
  DropDownModel addAssemblyDrop = DropDownModel();
  DropDownModel addCategoryDrop = DropDownModel();
  DropDownModel addPriorityDrop = DropDownModel();
//  DropDownModel detailStatusDrop = DropDownModel();
  RxList<DropDownModel> statusDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> categoryDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> priorityDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> assemblyDropList = <DropDownModel>[].obs;

  RxList<CasesData> data = <CasesData>[].obs;
  RxList<CasesData> dataCopy = <CasesData>[].obs;

  //detail
  RxList<CaseDetailData> dataDetail = <CaseDetailData>[].obs;
  RxList<CaseDocument> detailDocument = <CaseDocument>[].obs;
  RxList<CaseStatus> detailStatus = <CaseStatus>[].obs;
  RxList<ContactPersonDetail> detailContactPerson = <ContactPersonDetail>[].obs;

  final repo = CasesRepository();
  final catRepo = CategoryRepository();
  final priorRepo = PriorityRepository();
  final assemblyRepo = AssemblyRepository();
  var pageIndex = 1.obs;
  var pageSize = 10.obs;
  var totalCount = 1.obs;
  RxString error = ''.obs;
  var isReminder = false.obs;
  String caseId = '';

  var persons = <AddPersonModel>[].obs;
  var contactPersons = <Map<String, String>>[].obs;

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
    getAssembly();
    getCategory();
    getPriority();
  }

  void addMoreContactPerson(String name, String mobile, String designation) {
    if (name.isNotEmpty && mobile.isNotEmpty && designation.isNotEmpty) {
      contactPersons.add({
        "name": name,
        "mobile": mobile,
        "designation": designation,
      });
    }
  }

  RxString imageName = ''.obs; // Observable for the file name
  Uint8List? pickedFileBytes; // For file bytes
  String? encodedData;
  //String? addNew = '';

  Future<void> pickImage(
      ImageSource? imageSource, String type, String value) async {
    if (imageSource != null) {
      final ImagePicker picker = ImagePicker();
// Pick an image.

      final XFile? image = await picker.pickImage(source: imageSource);
      // Set the image name and encode data to Base64
      if (image != null) {
        String dateFormat = getFormattedTimestamp();
        if (value == 'program') {
          imageName.value = "$dateFormat.${image.name.split('.').last}";
          uploadController.text = imageName.value;
          pickedFileBytes = await image.readAsBytes();
          encodedData = base64Encode(pickedFileBytes!);
        }
        // else if (value == 'add document') {
        //   imageName.value = "$dateFormat.${image.name.split('.').last}";
        //   addNew = 'add new Document';
        //   pickedFileBytes = await image.readAsBytes();
        //   encodedData = base64Encode(pickedFileBytes!);
        //   addDocument();
        // }
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
        if (value == 'program') {
          imageName.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;
          uploadController.text = imageName.value;

          encodedData = base64Encode(pickedFileBytes!);
        }
        // else if (value == 'add document') {
        //   imageName.value =
        //       "$dateFormat.${result.files.single.name.split('.').last}";
        //   pickedFileBytes = result.files.single.bytes;
        //   addNew = 'add new Document';

        //   encodedData = base64Encode(pickedFileBytes!);
        //   addDocument();
        // }
      } else {
        imageName.value = '';
      }
    }
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

  void addProgramSchedule() async {
    isLoading(true);
    final res = await repo.addCases(
        type: ConstValues.typeProgram,
        assemblyId: addAssemblyDrop.id ?? '',
        priorityId: addPriorityDrop.id ?? '',
        time: timeController.text.trim(),
        date: dateController.text.trim(),
        location: locationController.text.trim(),
        title: titleController.text.trim(),
        description: descriptController.text.trim(),
        reminderDate: remindDateController.text.trim(),
        addedBy: LocalStorageKey.userData.id.toString(),
        addedType: LocalStorageKey.userData.username,
        accountId: LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
        caseId = resData.id.toString();
        if (contactPersons.isNotEmpty) {
          addContactPerson();
        }
        if (imageName.value != '') {
          addDocument();
        }
      }
      clear();
      getProgramSchedules();
      Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
    });
  }

  void addContactPerson() async {
    isLoading(true);
    final res = await repo.addContactPerson(contactPersons
        .map((e) => AddPersonModel(
            accountId: LocalStorageKey.userData.accountId,
            type: ConstValues.typeProgram,
            name: e["name"] ?? '',
            designation: e["designation"] ?? '',
            mobile: e["mobile"] ?? '',
            caseId: caseId))
        .toList());

    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {}
    });
  }

  void addDocument() async {
    isLoading(true);
    final res = await repo.addDocument(
        accountId: LocalStorageKey.userData.accountId,
        type: ConstValues.typeProgram,
        document: imageName.value,
        caseId: caseId,
        imageData: encodedData,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {}
    });
  }

  clear() {
    nameController.clear();
    titleController.clear();
    descriptController.clear();
    mobileController.clear();
    remindDateController.clear();
    locationController.clear();
    timeController.clear();
    contactPersons.clear();
    //addTypeDrop = DropDownModel();

    addAssemblyDrop = DropDownModel();
    addPriorityDrop = DropDownModel();

    dateController.clear();

    uploadController.clear();
    imageName.value = '';
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getProgramSchedules(); // Fetch the employee list for the new page
    }
  }
}
