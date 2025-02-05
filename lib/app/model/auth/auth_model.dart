import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  bool? status;
  String? message;
  Data? data;

  AuthModel({
    this.status,
    this.message,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? empId;
  String? token;

  Data({
    this.empId,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        empId: json["emp_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "token": token,
      };
}

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool? status;
  String? message;
  List<UserData>? data;

  UserResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserData {
  int? id;
  String? studentname;
  String? academicYear;
  String? courseName;
  String? mobile;
  String? email;
  String? location;
  String? image;

  UserData({
    this.id,
    this.studentname,
    this.academicYear,
    this.courseName,
    this.mobile,
    this.email,
    this.location,
    this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        studentname: json["studentname"],
        academicYear: json["academic_year"],
        courseName: json["course_name"],
        mobile: json["mobile"],
        email: json["email"],
        location: json["location"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentname": studentname,
        "academic_year": academicYear,
        "course_name": courseName,
        "mobile": mobile,
        "email": email,
        "location": location,
        "image": image,
      };
}
