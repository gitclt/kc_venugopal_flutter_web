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

class ReminderController extends GetxController {
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
  final TextEditingController uploadController = TextEditingController();
  final TextEditingController remindDateController = TextEditingController();

  final TextEditingController activityController = TextEditingController();
  final TextEditingController reminderDateController = TextEditingController();
  final TextEditingController remindDocumentController =
      TextEditingController();
  DropDownModel statusFilter = DropDownModel();
  DropDownModel typeFilter = DropDownModel();
  DropDownModel priorityFilter = DropDownModel();
  DropDownModel addAssemblyDrop = DropDownModel();
  DropDownModel addTypeDrop = DropDownModel();
  DropDownModel addPriorityDrop = DropDownModel();
  DropDownModel detailStatusDrop = DropDownModel();
  RxList<DropDownModel> statusDropList = <DropDownModel>[].obs;
  RxList<DropDownModel> typeDropList = <DropDownModel>[].obs;
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
  String reminderType = '';
  String reminderId = '';
  RxString detailImagename = ''.obs;

  var contactPersons = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDropDownValues();
    getReminders();
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

    for (var v in ConstValues().reminderTypes) {
      typeDropList.add(DropDownModel(id: v.id.toString(), name: v.name));
    }
    getPriority();
    getAssembly();
  }

  void getReminders() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: pageSize.value == 0 ? '0' : pageIndex.value.toString(),
        pageSize: pageSize.value == 0 ? '0' : pageSize.value.toString(),
        type: typeFilter.name?.toLowerCase() ?? ConstValues.typeInaug,
        fromDate: fromDateController.text.trim(),
        toDate: toDateController.text.trim(),
        status: statusFilter.name?.toLowerCase() ?? '',
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
  String? addNew = '';

  Future<void> pickImage(
      ImageSource? imageSource, String type, String value) async {
    if (imageSource != null) {
      final ImagePicker picker = ImagePicker();
// Pick an image.

      final XFile? image = await picker.pickImage(source: imageSource);
      // Set the image name and encode data to Base64
      if (image != null) {
        String dateFormat = getFormattedTimestamp();
        if (value == 'reminder') {
          imageName.value = "$dateFormat.${image.name.split('.').last}";
          uploadController.text = imageName.value;
          pickedFileBytes = await image.readAsBytes();
          encodedData = base64Encode(pickedFileBytes!);
        } else if (value == 'detailCase') {
          detailImagename.value = "$dateFormat.${image.name.split('.').last}";
          remindDocumentController.text = detailImagename.value;
          pickedFileBytes = await image.readAsBytes();
          encodedData = base64Encode(pickedFileBytes!);
        } else if (value == 'add document') {
          imageName.value = "$dateFormat.${image.name.split('.').last}";
          addNew = 'add new Document';
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
        if (value == 'reminder') {
          imageName.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;
          uploadController.text = imageName.value;

          encodedData = base64Encode(pickedFileBytes!);
        } else if (value == 'detailCase') {
          detailImagename.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;
          remindDocumentController.text = detailImagename.value;

          encodedData = base64Encode(pickedFileBytes!);
        } else if (value == 'add document') {
          imageName.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;
          addNew = 'add new Document';

          encodedData = base64Encode(pickedFileBytes!);
          addDocument();
        }
      } else {
        imageName.value = '';
      }
    }
  }

  void addReminder() async {
    isLoading(true);
    final res = await repo.addCases(
        type: addTypeDrop.name?.toLowerCase() ?? '',
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
        clear();
        getReminders();
        Get.rootDelegate.toNamed(Routes.REMINDER);
      }
    });
  }

  void addContactPerson() async {
    isLoading(true);
    final res = await repo.addContactPerson(contactPersons
        .map((e) => AddPersonModel(
            accountId: LocalStorageKey.userData.accountId,
            type: addTypeDrop.name?.toLowerCase() ?? '',
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
        type: addTypeDrop.name?.toLowerCase() ?? '',
        document: imageName.value,
        caseId: addNew != '' ? reminderId : caseId,
        imageData: encodedData,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
        if (addNew != '') {
          getReminderDetail();
        }
      }
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
    addTypeDrop = DropDownModel();

    addAssemblyDrop = DropDownModel();
    addPriorityDrop = DropDownModel();

    dateController.clear();

    uploadController.clear();
    imageName.value = '';
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getReminders(); // Fetch the employee list for the new page
    }
  }

  void getReminderDetail() async {
    setRxRequestStatus(Status.loading);
    dataDetail.clear();
    detailStatus.clear();
    detailContactPerson.clear();
    detailDocument.clear();
    addNew = '';
    final response = await repo.getCaseDetails(
      accountId: LocalStorageKey.userData.accountId.toString(),
      id: reminderId,
      type: reminderType,
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

  void updateStatus() async {
    isStatusLoading(true);
    final res = await repo.updateStatus(
        id: reminderId,
        type: reminderType,
        status: detailStatusDrop.name ?? '',
        accountId: LocalStorageKey.userData.accountId.toString(),
        remark: activityController.text.trim(),
        createdUserId: LocalStorageKey.userData.id.toString(),
        reminderDate: reminderDateController.text.trim(),
        document: detailImagename.value,
        fileData: encodedData ?? '');
    res.fold((failure) {
      isStatusLoading(false);
      setError(error.toString());
    }, (resData) {
      isStatusLoading(false);
      if (resData.status!) {
        detailClear();
        getReminders();
        Get.rootDelegate.toNamed(Routes.REMINDER);
      }
    });
  }

  detailClear() {
    activityController.clear();
    detailStatusDrop = DropDownModel();
    remindDocumentController.clear();
    remindDocumentController.clear();
    detailImagename.value = '';
    imageName.value = '';
    addNew = '';
  }
}
