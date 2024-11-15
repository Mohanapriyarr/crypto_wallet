import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inocyx/data/theme/themes.dart';
import 'package:inocyx/routes/app_pages.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    themeMode: ThemeMode.light,
    theme: Themes.light,
  ));
}
