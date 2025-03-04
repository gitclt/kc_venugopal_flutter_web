// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const ROOT = _Paths.ROOT;
  static const DASHBOARD = _Paths.HOME + _Paths.DASHBOARD;
  static const ALL_ACTIVITIES =
      _Paths.HOME + _Paths.DASHBOARD + _Paths.ALL_ACTIVITIES;
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
  static const ADD_SUPPORT_REQUEST =
      _Paths.HOME + _Paths.SUPPORT_REQUEST + _Paths.ADD_SUPPORT_REQUEST;
  static const SUPPORT_REQUEST_DETAIL =
      _Paths.HOME + _Paths.SUPPORT_REQUEST + _Paths.SUPPORT_REQUEST_DETAIL;
  static const PROGRAM_SCHEDULE = _Paths.HOME + _Paths.PROGRAM_SCHEDULE;
  static const ADD_PROGRAM_SCHEDULE =
      _Paths.HOME + _Paths.PROGRAM_SCHEDULE + _Paths.ADD_PROGRAM_SCHEDULE;
  static const CASES = _Paths.CASES;
  static const REMINDER = _Paths.HOME + _Paths.REMINDER;
  static const ADD_REMINDER =
      _Paths.HOME + _Paths.REMINDER + _Paths.ADD_REMINDER;
  static const REMINDER_DETAIL =
      _Paths.HOME + _Paths.REMINDER + _Paths.REMINDER_DETAIL;
  static const PROGRAM_SCHEDULE_DETAIL =
      _Paths.HOME + _Paths.PROGRAM_SCHEDULE + _Paths.PROGRAM_SCHEDULE_DETAIL;
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
  static const ADD_SUPPORT_REQUEST = '/add-support-request';
  static const SUPPORT_REQUEST_DETAIL = '/support-request-detail';
  static const PROGRAM_SCHEDULE = '/program-schedule';
  static const ADD_PROGRAM_SCHEDULE = '/add-program-schedule';
  static const PROGRAM_SCHEDULE_DETAIL = '/program-schedule-detail';
  static const CASES = '/cases';
  static const REMINDER = '/reminder';
  static const ADD_REMINDER = '/add-reminder';
  static const REMINDER_DETAIL = '/reminder-detail';
  static const ALL_ACTIVITIES = '/all-activities';
}
