import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';

class MasterUrl {
  static String baseUrl = kBaseUrl;

  // Category
  static String addCategory = '$baseUrl/case_category/Postcategory';
  static String categoryListApi = '$baseUrl/case_category/get_category';
  static String updateCategory = '$baseUrl/case_category/update_category';
  static String deleteCategory = '$baseUrl/case_category/delete_category';
}
