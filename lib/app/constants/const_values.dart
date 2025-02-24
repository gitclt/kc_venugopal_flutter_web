import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';

class ConstValues {
  static String typeSupport = 'support request';
  static String typeProgram = 'program schedule';
  static String typeWed = 'wedding';
  static String typeInaug = 'inauguration';
  static String typeBirth = 'birthday';
  static String typeDeath = 'death';

  List<DropDownModel> status = [
    DropDownModel(id: '', name: '--Select Status--'),
    DropDownModel(id: '1', name: 'Support Requested'),
    DropDownModel(id: '2', name: "Request Accepted"),
    DropDownModel(id: '3', name: "Attended"),
    DropDownModel(id: '4', name: "Completed"),
    DropDownModel(id: '5', name: "Opened"),
    DropDownModel(id: '6', name: "Processing"),
    DropDownModel(id: '7', name: "Action 1"),
    DropDownModel(id: '8', name: "Followup"),
    DropDownModel(id: '9', name: "Closed"),
    DropDownModel(id: '10', name: "created_user_id"),
    DropDownModel(id: '11', name: "app_version_code"),
    DropDownModel(id: '12', name: "Pending"),
  ];

  List<DropDownModel> reminderTypes = [
    DropDownModel(id: '1', name: 'Wedding'),
    DropDownModel(id: '2', name: "Inauguration"),
    DropDownModel(id: '3', name: "Birthday"),
    DropDownModel(id: '4', name: "Death"),
  ];
}
