import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/assembly_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/add_subadmin_assembly.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/subadmin_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/assembly_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/subadmin_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/utils.dart';

class SubAdminController extends GetxController {
  final rxRequestStatus = Status.completed.obs;

  RxString error = ''.obs;
  final repo = SubadminRepository();
  final assemblyRepo = AssemblyRepository();
  RxList<SubAdminData> data = <SubAdminData>[].obs;
  RxList<SubAdminData> dataCopy = <SubAdminData>[].obs;
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  RxBool isLoading = false.obs;
  String editId = '';
  String subAdminId = '';
  final filterItem = ''.obs;

  List<AssemblyData> assemblyData = <AssemblyData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssembly();
    getSubAdmins();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void getSubAdmins() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final res =
        await repo.getSubAdmin(LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
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

  void getAssembly() async {
    setRxRequestStatus(Status.loading);
    assemblyData.clear();

    final res = await assemblyRepo
        .getAssembly(LocalStorageKey.userData.accountId.toString());
    res.fold((failure) {
      setRxRequestStatus(Status.completed);
      setError(error.toString());
    }, (resData) {
      setRxRequestStatus(Status.completed);
      if (resData.data != null) {
        assemblyData.addAll(resData.data!);
      }
    });
  }

//add
  void addSubAdmin() async {
    isLoading(true);
    final res = await repo.addSubAdmin(
        name: nameController.text.trim(),
        accountId: LocalStorageKey.userData.accountId);
    res.fold(
      (failure) {
        isLoading(false);
        Utils.snackBar('Error', failure.message);
        setError(error.toString());
      },
      (resData) {
        if (resData.status!) {

          isLoading(false);
          Get.rootDelegate.toNamed(Routes.SUB_ADMIN);
          Utils.snackBar('Sub Admin', resData.message ?? '', type: 'success');

          getSubAdmins();
        }
      },
    );
  }

  
  //edit
  editSubAdmin() async {
    isLoading(true);
    final res = await repo.editSubAdmin(
        id: editId,
        name: nameController.text,
        accountId: LocalStorageKey.userData.accountId.toString());
    res.fold(
      (failure) {
        isLoading(false);
        Utils.snackBar('Error', failure.message);
        setError(error.toString());
      },
      (resData) {
        if (resData.status!) {
          isLoading(false);
          Get.rootDelegate.toNamed(Routes.SUB_ADMIN);
          Utils.snackBar('Priority', resData.message ?? '', type: 'success');

          getSubAdmins();

          // clrValue();
        }
      },
    );
  }

  //delete
  void delete(String id) async {
    final res = await repo.deleteSubAdmin(id: id);
    res.fold((failure) {
      Utils.snackBar('Error', failure.message);
      setError(error.toString());
    }, (resData) {
      Utils.snackBar('Priority', resData.message!, type: 'success');
      getSubAdmins();
    });
  }

  void editClick(SubAdminData data) {
    nameController = TextEditingController(text: data.name);
    editId = data.id ?? '';
    Get.rootDelegate.toNamed(Routes.ADD_SUBADMIN);
  }

  void searchData(String value) {
    data.clear();

    if (value.isEmpty) {
      data.addAll(dataCopy);
    } else {
      data.clear();
      data.addAll(dataCopy
          .where((data) =>
              data.name!.toLowerCase().contains(value.toLowerCase()) ||
              data.username!.toLowerCase().contains(value.toLowerCase()) ||
              data.mobile!.toLowerCase().contains(value.toLowerCase()) ||
              data.contactPerson!.toLowerCase().contains(value.toLowerCase()))
          .toList());
    }
  }
}
