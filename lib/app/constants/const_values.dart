import 'package:kc_venugopal_flutter_web/app/domain/entity/dropdown_entity.dart';

class ConstValues {
  static String typeSupport = 'support request';
  static String typeProgram = 'program schedule';
  static String typeWed = 'wedding';
  static String typeInaug = 'inauguration';
  static String typeBirth = 'birthday';
  static String typeDeath = 'death';

  List<DropDownModel> status = [
    DropDownModel(id: '1', name: 'support requested'),
    DropDownModel(id: '2', name: "request accepted"),
    DropDownModel(id: '3', name: "attended"),
    DropDownModel(id: '4', name: "completed"),
    DropDownModel(id: '5', name: "opened"),
    DropDownModel(id: '6', name: "processing"),
    DropDownModel(id: '7', name: "action 1"),
    DropDownModel(id: '8', name: "followup"),
    DropDownModel(id: '9', name: "closed"),
    DropDownModel(id: '10', name: "created_user_id"),
    DropDownModel(id: '11', name: "app_version_code")
  ];
}
