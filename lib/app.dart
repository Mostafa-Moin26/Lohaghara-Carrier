import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/routes/app_pages.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import 'core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lohaghara Carrier',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
