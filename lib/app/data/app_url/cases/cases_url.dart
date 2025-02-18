import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';

class CasesUrl {
  static String baseUrl = kBaseUrl;

  static String viewCases = '$baseUrl/case_cases/view_cases';
  static String addCases = '$baseUrl/case_cases/Postcases';
  static String updateCases = '$baseUrl/case_cases/Updatecases';
  static String deleteCases = '$baseUrl/case_cases/delete_cases';

  //add contact person
  static String addContactPerson =
      '$baseUrl/case_contactperson/Post_case_contactperson';

  //upload document
  static String addDocument = '$baseUrl/case_documents/case_documentadd';
  //detail
  static String viewCaseDetails = '$baseUrl/case_cases/cases_detail';

  //update status
  static String updateCaseStatus = '$baseUrl/case_cases/update_status';
}
