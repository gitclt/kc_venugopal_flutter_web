import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kc_venugopal_flutter_web/app/core/getx_localization/languages.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/theme_data.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('token');
  runApp(
    Sizer(builder: (context, orientation, screentype) {
      return GetMaterialApp.router(
        translations: Languages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        title: 'CASE MANAGEMENT',
        getPages: AppPages.routes,
        theme: AppTheme.defaultTheme,
        darkTheme: AppTheme.defaultTheme,
        debugShowCheckedModeBanner: false,
      );
    }),
  );
}
