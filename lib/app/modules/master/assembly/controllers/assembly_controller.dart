import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/assembly_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/assembly_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/utils.dart';

class AssemblyController extends GetxController {
  final rxRequestStatus = Status.completed.obs;

  RxString error = ''.obs;
  final catRepo = AssemblyRepository();
  RxList<AssemblyData> data = <AssemblyData>[].obs;
  RxList<AssemblyData> dataCopy = <AssemblyData>[].obs;
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  RxBool isLoading = false.obs;
  String editId = '';
  final filterItem = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getAssembly();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void getAssembly() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final res = await catRepo
        .getAssembly(  accountId: LocalStorageKey.userData.accountId.toString(),
      subadminId: LocalStorageKey.userData.type == 'subadmin'
          ? LocalStorageKey.userData.id.toString()
          : null,
      type: LocalStorageKey.userData.type == 'subadmin'
          ? 'subadmin'
          : null,);
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

  //add
  void addAssembly() async {
    isLoading(true);
    final res = await catRepo.addAssembly(
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
          Get.rootDelegate.toNamed(Routes.ASSEMBLY);
          Utils.snackBar('Category', resData.message ?? '', type: 'success');

          getAssembly();
        }
      },
    );
  }

  //edit
  editAssembly() async {
    isLoading(true);
    final res = await catRepo.editAssembly(
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
          Get.rootDelegate.toNamed(Routes.ASSEMBLY);
          Utils.snackBar('Category', resData.message ?? '', type: 'success');

          getAssembly();

          // clrValue();
        }
      },
    );
  }

  //delete
  void delete(String id) async {
    final res = await catRepo.deleteAssembly(id: id);
    res.fold((failure) {
      Utils.snackBar('Error', failure.message);
      setError(error.toString());
    }, (resData) {
      Utils.snackBar('Category', resData.message!, type: 'success');
      getAssembly();
    });
  }

  void editClick(AssemblyData data) {
    nameController = TextEditingController(text: data.name);
    editId = data.id ?? '';
    Get.rootDelegate.toNamed(Routes.ADD_ASSEMBLY);
  }

  void searchData(String value) {
    data.clear();

    if (value.isEmpty) {
      data.addAll(dataCopy);
    } else {
      data.clear();
      data.addAll(dataCopy
          .where(
              (data) => data.name!.toLowerCase().contains(value.toLowerCase()))
          .toList());
    }
  }
}
