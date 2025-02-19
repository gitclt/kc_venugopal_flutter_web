import 'dart:convert';
import 'dart:typed_data';

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

class CasesController extends GetxController with GetTickerProviderStateMixin {
  final rxRequestStatus = Status.completed.obs;
  final isDropLoading = false.obs;
  var isLoading = false.obs;
  var isStatusLoading = false.obs;
  final formkey = GlobalKey<FormState>();
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

  final TextEditingController timeController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();

  //update
  final TextEditingController activityController = TextEditingController();
  final TextEditingController reminderDateController = TextEditingController();
  final TextEditingController remindDocumentController =
      TextEditingController();
  DropDownModel detailStatusDrop = DropDownModel();

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
  String supportId = '';
  RxString error = ''.obs;
  RxString detailImagename = ''.obs;
  var isReminder = false.obs;
  late TabController tabController;

  //program schedule
  var persons = <AddPersonModel>[].obs;

  Map<String, String>? type;
  var source = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDropDownValues();
    type = Get.rootDelegate.arguments();
    if (type != null) {
      source.value = type!.entries.first.value;
      setTypeValues();
    }

    tabController = TabController(length: 2, vsync: this);
  }

  void setTypeValues() {
    switch (source.value) {
      case 'support request':
        // Handle support request logic
        getCases();
        print('Fetching support requests...');
        break;
      case 'program schedule':
        // Handle program schedule logic
        getCases();
        print('Fetching program schedule...');
        break;
      case 'reminders':
        // Handle reminders logic
        getCases();
        print('Fetching reminders...');
        break;
      default:
        break;
    }
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

  void getDropDownValues() {
    for (var v in ConstValues().status) {
      statusDropList.add(DropDownModel(id: v.id.toString(), name: v.name));
    }
    getCategory();
    getPriority();
    getAssembly();
  }

  void getCases() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: pageSize.value == 0 ? '0' : pageIndex.value.toString(),
        pageSize: pageSize.value == 0 ? '0' : pageSize.value.toString(),
        type: source.value == 'support request'
            ? ConstValues.typeSupport
            : source.value == 'program schedule'
                ? ConstValues.typeProgram
                : ConstValues.typeWed,
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

  RxString imageName = ''.obs; // Observable for the file name
  Uint8List? pickedFileBytes; // For file bytes
  String? encodedData;

  Future<void> pickImage(ImageSource type, String value) async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: type);

    if (image != null) {
      // Set the image name and encode data to Base64

      String dateFormat = getFormattedTimestamp();
      if (value == 'support') {
        imageName.value = "$dateFormat.${image.name.split('.').last}";
        uploadController.text = imageName.value;
      } else if (value == 'detailCase') {
        detailImagename.value = "$dateFormat.${image.name.split('.').last}";
        remindDocumentController.text = detailImagename.value;
      }

      pickedFileBytes = await image.readAsBytes();
      encodedData = base64Encode(pickedFileBytes!);
    } else {
      // Reset image name if no file selected
      imageName.value = '';
    }
  }

  void addCase() async {
    isLoading(true);
    final res = await repo.addCases(
        type: source.value == 'support request'
            ? ConstValues.typeSupport
            : source.value == 'program schedule'
                ? ConstValues.typeProgram
                : ConstValues.typeWed,
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
        addDocument();
      }
    });
  }

  void addDocument() async {
    isLoading(true);
    final res = await repo.addDocument(
        accountId: LocalStorageKey.userData.accountId,
        type: ConstValues.typeSupport,
        document: imageName.value,
        imageData: encodedData,
        createdUserId: LocalStorageKey.userData.id);
    res.fold((failure) {
      isLoading(false);
      setError(error.toString());
    }, (resData) {
      if (resData.status!) {
        isLoading(false);
        clear();
        getCases();
        Get.rootDelegate.toNamed(Routes.SUPPORT_REQUEST);
      } else {
        isLoading(false);
      }
    });
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getCases(); // Fetch the employee list for the new page
    }
  }

  void getSupportDetail() async {
    setRxRequestStatus(Status.loading);
    dataDetail.clear();

    final response = await repo.getCaseDetails(
      accountId: LocalStorageKey.userData.accountId.toString(),
      id: supportId,
      type: ConstValues.typeSupport,
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
        id: supportId,
        type: ConstValues.typeSupport,
        status: detailStatusDrop.name,
        accountId: LocalStorageKey.userData.accountId.toString(),
        remark: activityController.text.trim(),
        createdUserId: LocalStorageKey.userData.id.toString(),
        reminderDate: reminderDateController.text.trim(),
        document: detailImagename.value,
        fileData: encodedData);
    res.fold((failure) {
      isStatusLoading(false);
      setError(error.toString());
    }, (resData) {
      isStatusLoading(false);
      if (resData.status!) {
        detailClear();
        getCases();
        Get.rootDelegate.toNamed(Routes.SUPPORT_REQUEST);
      }
    });
  }

  clear() {
    nameController.clear();
    addressController.clear();
    mobileController.clear();
    emailController.clear();
    locationController.clear();
    addCategoryDrop = DropDownModel(id: '', name: '');
    addAssemblyDrop = DropDownModel(id: '', name: '');
    addPriorityDrop = DropDownModel(id: '', name: '');
    caseSubController.clear();
    caseTitleController.clear();
    dateController.clear();
    commentController.clear();
    uploadController.clear();
    imageName.value = '';
  }

  detailClear() {
    activityController.clear();
    detailStatusDrop = DropDownModel(id: '', name: '');
    remindDocumentController.clear();
    remindDocumentController.clear();
    detailImagename.value = '';
  }

  Color priorityColor(String value) {
    if (value == 'high') {
      return Colors.red;
    } else if (value == 'low') {
      return Colors.green;
    }
    return Colors.grey;
  }
}
