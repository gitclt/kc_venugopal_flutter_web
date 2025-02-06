import 'dart:convert';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kc_venugopal_flutter_web/app/data/local/user_preference/user_prefrence_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/app_exceptions.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(
    String url,
  ) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;

    try {
      final value = await UserPreference().getUser();
      if (value == null) {
        final userPreference = UserPreference();
        await userPreference.removeUser();

        userPreference.goToSplash();
        return;
      }

      final headers = {
        "XApiKey": "$value",
      };

      Get.printInfo(info: "XApiKey $value");

      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 10),
          );

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      // print(responseJson);
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApi(
    var data,
    dynamic url, {
    bool isJson = false,
  }) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final value = await UserPreference().getUser();

      if (value == null) {
        final userPreference = UserPreference();
        await userPreference.removeUser();

        userPreference.goToSplash();
        return;
      }
      Get.printInfo(info: "XApiKey: ${value ?? ""}");
      final headers = {
        "XApiKey": "$value",
        if (isJson) "Content-Type": "application/json",
      };
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  Future<String> getPublicIP() async {
    final url = Uri.parse('https://api.ipify.org?format=text');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Failed';

      // throw Exception('Failed to get IP address');
    }
  }

  dynamic returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);

        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        final userPreference = UserPreference();
        await userPreference.removeUser();
        userPreference.goToSplash();

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
    }
  }

  @override
  Future loginApi(dynamic data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future deleteApi(
    data,
    String url,
  ) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final value = await UserPreference().getUser();

      if (value == null) {
        final userPreference = UserPreference();
        await userPreference.removeUser();

        userPreference.goToSplash();
        return;
      }
      Get.printInfo(info: "XApiKey: ${value ?? ""}");
      final headers = {
        "XApiKey": "$value",
      };
      final response = await http
          .delete(
            Uri.parse(url),
            body: data,
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future putApi(data, String url, {bool isJson = false}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      final value = await UserPreference().getUser();

      if (value == null) {
        final userPreference = UserPreference();
        await userPreference.removeUser();

        userPreference.goToSplash();
        return;
      }
      Get.printInfo(info: "XApiKey: ${value ?? ""}");
      final headers = {
        "XApiKey": "$value",
        if (isJson) "Content-Type": "application/json",
      };
      final response = await http
          .put(
            Uri.parse(url),
            body: data,
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }
}
