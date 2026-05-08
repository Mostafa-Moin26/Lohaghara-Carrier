import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/dashboard_screen.dart';
import 'package:lohaghara_carrier/features/factory/presentation/factory_view.dart';
import 'package:lohaghara_carrier/features/more/presentation/settings_screen.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/all_record_screen.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/reports_screen.dart';

import 'core/constants/colors.dart';
import 'core/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: dark ? AppColors.black : AppColors.background,
              indicatorColor: AppColors.primaryColor.withValues(alpha: 0.2),
            ),
          ),
          child: NavigationBar(
            height: 60,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: controller.updateIndex,

            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                selectedIcon: Icon(Iconsax.home, color: AppColors.primaryDark),
                label: AppTextStrings.dashboard,
              ),

              NavigationDestination(
                icon: Icon(Iconsax.buildings_2),
                selectedIcon: Icon(
                  Iconsax.buildings_2,
                  color: AppColors.primaryDark,
                ),
                label: AppTextStrings.factories,
              ),

              NavigationDestination(
                icon: Icon(Iconsax.document_text),
                selectedIcon: Icon(
                  Iconsax.document_text,
                  color: AppColors.primaryDark,
                ),
                label: AppTextStrings.records,
              ),

              NavigationDestination(
                icon: Icon(Iconsax.receipt_text),
                selectedIcon: Icon(
                  Iconsax.receipt_text,
                  color: AppColors.primaryDark,
                ),
                label: AppTextStrings.reports,
              ),

              NavigationDestination(
                icon: Icon(Iconsax.setting_2),
                selectedIcon: Icon(
                  Iconsax.setting_2,
                  color: AppColors.primaryDark,
                ),
                label: AppTextStrings.more,
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  final screens = [
    const Dashboard(),
    FactoryView(),
    const AllRecord(),
    ReportsScreen(),
    SettingsScreen(),
  ];
}
