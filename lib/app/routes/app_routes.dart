part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const ROOT = _Paths.ROOT;
  static const DASHBOARD = _Paths.HOME + _Paths.DASHBOARD;
  static const MASTER = _Paths.HOME + _Paths.MASTER;
  static const CATEGORY = _Paths.HOME + _Paths.CATEGORY;
  static const ADD_CATEGORY =
      _Paths.HOME + _Paths.CATEGORY + _Paths.ADD_CATEGORY;
  static const PRIORITY = _Paths.HOME + _Paths.PRIORITY;
  static const ADD_PRIORITY =
      _Paths.HOME + _Paths.PRIORITY + _Paths.ADD_PRIORITY;
  static const ASSEMBLY = _Paths.HOME + _Paths.ASSEMBLY;
  static const ADD_ASSEMBLY =
      _Paths.HOME + _Paths.ASSEMBLY + _Paths.ADD_ASSEMBLY;
  static const SUB_ADMIN = _Paths.HOME + _Paths.SUB_ADMIN;
  static const ADD_SUBADMIN =
      _Paths.HOME + _Paths.SUB_ADMIN + _Paths.ADD_SUB_ADMIN;
  static const SUPPORT_REQUEST = _Paths.HOME + _Paths.SUPPORT_REQUEST;
  static const PROGRAM_SCHEDULE = _Paths.HOME + _Paths.PROGRAM_SCHEDULE;
  static const ADD_PROGRAM_SCHEDULE = _Paths.HOME + _Paths.PROGRAM_SCHEDULE + _Paths.ADD_PROGRAM_SCHEDULE;

}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const ROOT = '/';
  static const DASHBOARD = '/dashboard';
  static const MASTER = '/master';
  static const CATEGORY = '/category';
  static const ADD_CATEGORY = '/add-category';
  static const PRIORITY = '/priority';
  static const ADD_PRIORITY = '/add-priority';
  static const ASSEMBLY = '/assembly';
  static const ADD_ASSEMBLY = '/add-assembly';
  static const SUB_ADMIN = '/sub-admin';
  static const ADD_SUB_ADMIN = '/add-sub_admin';
  static const SUPPORT_REQUEST = '/support-request';
  static const PROGRAM_SCHEDULE = '/program-schedule';
  static const ADD_PROGRAM_SCHEDULE = '/add-program-schedule';
}
