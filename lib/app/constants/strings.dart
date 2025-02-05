// const String kBaseUrl = "https://crmtrail.demospro2023.tk";



import 'package:kc_venugopal_flutter_web/app/model/auth/auth_model.dart';

const String kBaseUrl = s1;
const String kBaseUrlForImage = "$kBaseUrl/public/assets/web";
const bool isStaging = true;

const String s1 = "http://192.168.1.101:8088/api";
//const String s1 = "https://wayanad.gitonline.in/api";


class LocalStorageKey {
  static String token = "USER_TOKEN";
  static String type = "USER_TYPE";
  static String roleId = "ROLE_ID";
  static String roleName = "ROLE_NAME";
  static String userName = "USER_NAME";
  static String empId = "EMP_ID";
  static UserData userData = UserData();

  // static List<Branch> userBranch = [];
  // static List<Privilage> privilage = [];
}
