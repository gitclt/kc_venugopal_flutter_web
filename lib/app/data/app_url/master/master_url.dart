import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';

class MasterUrl {
  static String baseUrl = kBaseUrl;

  // Category
  static String addCategory = '$baseUrl/case_category/Postcategory';
  static String categoryListApi = '$baseUrl/case_category/get_category';
  static String updateCategory = '$baseUrl/case_category/update_category';
  static String deleteCategory = '$baseUrl/case_category/delete_category';

  //Priority
  static String addPriority = '$baseUrl/case_priority/Postpriority';
  static String priorityListApi = '$baseUrl/case_priority/get_priority';
  static String updatePriority = '$baseUrl/case_priority/update_priority';
  static String deletePriority = '$baseUrl/case_priority/delete_priority';

  //Assembly
  static String addAssembly = '$baseUrl/case_assembly/Postassembly';
  static String assemblyListApi = '$baseUrl/case_assembly/get_assembly';
  static String updateAssembly = '$baseUrl/case_assembly/update_assembly';
  static String deleteAssembly = '$baseUrl/case_assembly/delete_assembly';

  //Sub Admin
  static String addSubAdmin = '$baseUrl/case_subadmin/Postsubadmin';
  static String addSubadminAssemly =
      '$baseUrl/subadmin_assembly/Post_subadmin_assembly';
  static String subAdminListApi = '$baseUrl/case_subadmin/get_subadmin';
  static String updateSubAdmin = '$baseUrl/case_subadmin/update_subadmin';
  static String deleteSubAdmin = '$baseUrl/case_subadmin/delete_subadmin';
  static String deleteSubAdminAssembly =
      '$baseUrl/subadmin_assembly/delete_subadmin_assembly';
}
