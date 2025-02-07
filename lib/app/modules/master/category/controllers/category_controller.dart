import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/category/category_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/master/category_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/utils.dart';

class CategoryController extends GetxController {
  final rxRequestStatus = Status.completed.obs;

  RxString error = ''.obs;
  final catRepo = CategoryRepository();
  RxList<CategoryData> data = <CategoryData>[].obs;
  RxList<CategoryData> dataCopy = <CategoryData>[].obs;
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  RxBool isLoading = false.obs;
  String editId = '';
  final filterItem = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void getCategory() async {
    setRxRequestStatus(Status.loading);
    data.clear();
    dataCopy.clear();
    final res = await catRepo
        .getCategory(LocalStorageKey.userData.accountId.toString());
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
  void addCategory() async {
    isLoading(true);
    final res = await catRepo.addCategory(
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
          Get.rootDelegate.toNamed(Routes.CATEGORY);
          Utils.snackBar('Category', resData.message ?? '', type: 'success');

          getCategory();
        }
      },
    );
  }

  //edit
  editCategory() async {
    isLoading(true);
    final res = await catRepo.editCategory(
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
          Get.rootDelegate.toNamed(Routes.CATEGORY);
          Utils.snackBar('Category', resData.message ?? '', type: 'success');

          getCategory();

          // clrValue();
        }
      },
    );
  }

  //delete
  void delete(String id) async {
    final res = await catRepo.deleteCategory(id: id);
    res.fold((failure) {
      Utils.snackBar('Error', failure.message);
      setError(error.toString());
    }, (resData) {
      Utils.snackBar('Category', resData.message!, type: 'success');
      getCategory();
    });
  }

  void editClick(CategoryData data) {
    nameController = TextEditingController(text: data.name);
    editId = data.id ?? '';
    Get.rootDelegate.toNamed(Routes.ADD_CATEGORY);
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
