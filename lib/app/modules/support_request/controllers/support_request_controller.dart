import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/assembly_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/category_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/priority_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

class SupportRequestController extends GetxController
    with GetTickerProviderStateMixin {
  final rxRequestStatus = Status.completed.obs;
  final isDropLoading = false.obs;
  var isLoading = false.obs;
  var isStatusLoading = false.obs;
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();

  //add
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController caseTitleController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController caseSubController = TextEditingController();
  final TextEditingController uploadController = TextEditingController();

  //update

  DropDownModel statusFilter = DropDownModel();
  DropDownModel categoryFilter = DropDownModel();
  DropDownModel priorityFilter = DropDownModel();
  DropDownModel addCategoryDrop = DropDownModel();
  DropDownModel addPriorityDrop = DropDownModel();
  DropDownModel addAssemblyDrop = DropDownModel();

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
  String supportId = '';

  RxString error = ''.obs;
  RxString detailImagename = ''.obs;
  var isReminder = false.obs;
  late TabController tabController;
  var assemblyId = '';

  @override
  void onInit() {
    super.onInit();
    assemblyId =
        LocalStorageKey.userAssembly.map((e) => e.assemblyId).join(',');
    getDropDownValues();
    getSupportRequests();
    tabController = TabController(length: 2, vsync: this);
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

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
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

  void getAssembly() async {
    isDropLoading(true);
    assemblyDropList.clear();
    assemblyDropList.add(DropDownModel(id: '', name: '--Select Assembly--'));
    final res = await assemblyRepo
        .getAssembly(  accountId: LocalStorageKey.userData.accountId.toString(),
      subadminId: LocalStorageKey.userData.type == 'subadmin'
          ? LocalStorageKey.userData.id.toString()
          : null,
      type: LocalStorageKey.userData.type == 'subadmin'
          ? 'subadmin'
          : null,);
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

  void getDropDownValues() {
    for (var v in ConstValues().status) {
      statusDropList.add(DropDownModel(id: v.id.toString(), name: v.name));
    }
    getCategory();
    getPriority();
    getAssembly();
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
        assemblyId:
            LocalStorageKey.userData.type == 'subadmin' ? assemblyId : null,
        fromDate: fromDateController.text.trim(),
        toDate: toDateController.text.trim(),
        status: statusFilter.name == '--Select Status--'
            ? ''
            : statusFilter.name ?? '',
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
        if (value == 'support') {
          imageName.value = "$dateFormat.${image.name.split('.').last}";
          uploadController.text = imageName.value;
          pickedFileBytes = await image.readAsBytes();
          encodedData = base64Encode(pickedFileBytes!);
        }
        // else if (value == 'detailCase') {
        //   detailImagename.value = "$dateFormat.${image.name.split('.').last}";
        //  // remindDocumentController.text = detailImagename.value;
        //   pickedFileBytes = await image.readAsBytes();
        //   encodedData = base64Encode(pickedFileBytes!);
        // } else if (value == 'add document') {
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
        if (value == 'support') {
          imageName.value =
              "$dateFormat.${result.files.single.name.split('.').last}";
          pickedFileBytes = result.files.single.bytes;
          uploadController.text = imageName.value;

          encodedData = base64Encode(pickedFileBytes!);
        }
        // else if (value == 'detailCase') {
        //   detailImagename.value =
        //       "$dateFormat.${result.files.single.name.split('.').last}";
        //   pickedFileBytes = result.files.single.bytes;
        // //  remindDocumentController.text = detailImagename.value;

        //   encodedData = base64Encode(pickedFileBytes!);
        // } else if (value == 'add document') {
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

  void addSupportRequest() async {
    isLoading(true);
    final res = await repo.addCases(
        type: ConstValues.typeSupport,
        assemblyId: addAssemblyDrop.id ?? '',
        priorityId: addPriorityDrop.id ?? '',
        categoryId: addCategoryDrop.id ?? '',
        date: dateController.text.trim(),
        location: locationController.text.trim(),
        title: caseTitleController.text.trim(),
        comment: commentController.text.trim(),
        subject: caseSubController.text.trim(),
        name: nameController.text.trim(),
        address: addressController.text.trim(),
        email: emailController.text.trim(),
        mobile: mobileController.text.trim(),
        addedBy: LocalStorageKey.userData.id.toString(),
        addedType: LocalStorageKey.userData.username,
        accountId: LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      if (resData.status!) {
        isLoading(false);
        if (imageName.value != '') {
          addDocument();
        }
      }
      clear();
      getSupportRequests();
      Get.rootDelegate.toNamed(Routes.SUPPORT_REQUEST);
    });
  }

  void addDocument() async {
    isLoading(true);
    final res = await repo.addDocument(
        accountId: LocalStorageKey.userData.accountId,
        type: ConstValues.typeSupport,
        document: imageName.value,
        imageData: encodedData,
        caseId: supportId,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
      } else {
        isLoading(false);
      }
    });
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getSupportRequests(); // Fetch the employee list for the new page
    }
  }

  clear() {
    nameController.clear();
    addressController.clear();
    mobileController.clear();
    emailController.clear();
    locationController.clear();
    addCategoryDrop = DropDownModel();
    addAssemblyDrop = DropDownModel();
    addPriorityDrop = DropDownModel();
    caseSubController.clear();
    caseTitleController.clear();
    dateController.clear();
    commentController.clear();
    uploadController.clear();
    imageName.value = '';
  }
}
