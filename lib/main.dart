import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kc_venugopal_flutter_web/app/core/getx_localization/languages.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('token');
  runApp(
    GetMaterialApp.router(
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'AMICOS',
      getPages: AppPages.routes,
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
    ),
  );
}

