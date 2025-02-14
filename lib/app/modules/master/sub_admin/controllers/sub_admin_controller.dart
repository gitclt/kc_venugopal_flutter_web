import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/assembly_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/add_subadmin.dart';
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

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    mobileController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
    final selectedAssembly =
        assemblyData.where((e) => e.isSelect!.value == true).toList();
    isLoading(true);

    final res = await repo.addSubAdmin(
        name: nameController.text.trim(),
        accountId: LocalStorageKey.userData.accountId,
        username: userNameController.text.trim(),
        password: passwordController.text.trim(),
        contact: contactController.text.trim(),
        mobile: mobileController.text.trim(),
        status: "active",
        data: selectedAssembly
            .map((e) => AddAssembly(assemblyId: e.id))
            .toList());
    res.fold(
      (failure) {
        isLoading(false);
        Utils.snackBar('Error', failure.message);
        setError(error.toString());
      },
      (resData) {
        if (resData.status!) {
          isLoading(false);
          clear();
          Get.rootDelegate.toNamed(Routes.SUB_ADMIN);
          Utils.snackBar('Sub Admin', resData.message ?? '', type: 'success');

          getSubAdmins();
        }
      },
    );
  }

  //edit
  editSubAdmin() async {
    final selectedAssembly =
        assemblyData.where((e) => e.isSelect!.value == true).toList();
    isLoading(true);
    final res = await repo.editSubAdmin(
        id: editId,
        name: nameController.text.trim(),
        accountId: LocalStorageKey.userData.accountId.toString(),
        username: userNameController.text.trim(),
        password: passwordController.text.trim(),
        contactPerson: contactController.text.trim(),
        mobile: mobileController.text.trim(),
        status: "active",
        data: selectedAssembly
            .map((e) => AddAssembly(assemblyId: e.id))
            .toList());
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
      Utils.snackBar('Sub Admin', resData.message!, type: 'success');
      getSubAdmins();
    });
  }

  void editClick(SubAdminData data) {
    nameController = TextEditingController(text: data.name);
    userNameController = TextEditingController(text: data.username);
    passwordController = TextEditingController(text: data.password);
    contactController = TextEditingController(text: data.contactPerson);
    mobileController = TextEditingController(text: data.mobile);
    for (var assembly in assemblyData) {
      assembly.isSelect?.value = false;
    }
    for (var subAdminAssembly in data.assemblies!) {
      for (var assembly in assemblyData) {
        if (assembly.name == subAdminAssembly.assembly) {
          assembly.isSelect?.value = true;
        }
      }
    }
    editId = data.id ?? '';
    Get.rootDelegate.toNamed(Routes.ADD_SUBADMIN);
  }

  clear() {
    nameController.clear();
    contactController.clear();
    mobileController.clear();
    userNameController.clear();
    passwordController.clear();
    for (var assembly in assemblyData) {
      assembly.isSelect?.value = false;
    }
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
