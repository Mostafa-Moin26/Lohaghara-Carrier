import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/bindings/initial_binding.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/routes/app_pages.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import 'core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTextStrings.appName,
      debugShowCheckedModeBanner: false,

      /// Theme Mode
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      /// Navigation
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

      /// Dependency Injection
      initialBinding: InitialBinding(),
    );
  }
}
