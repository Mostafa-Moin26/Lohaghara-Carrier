import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/dashboard_screen.dart';
import 'package:lohaghara_carrier/features/factory/presentation/factory_view.dart';
import 'package:lohaghara_carrier/features/more/presentation/settings_screen.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/all_record_screen.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/reports_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      /// =========================
      /// BODY
      /// =========================
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      /// =========================
      /// BOTTOM NAVIGATION BAR
      /// =========================
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: dark ? AppColors.black : AppColors.background,

            indicatorColor: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
        ),

        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 360;

            return Obx(
              () => NavigationBar(
                height: isSmallScreen ? 55 : 60,
                elevation: 0,

                selectedIndex: controller.selectedIndex.value,

                onDestinationSelected: controller.updateIndex,

                labelBehavior: isSmallScreen
                    ? NavigationDestinationLabelBehavior.alwaysHide
                    : NavigationDestinationLabelBehavior.alwaysShow,

                destinations: const [
                  /// =========================
                  /// DASHBOARD
                  /// =========================
                  NavigationDestination(
                    icon: Icon(Iconsax.home, size: 22),

                    selectedIcon: Icon(
                      Iconsax.home,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),

                    label: AppTextStrings.dashboard,
                  ),

                  /// =========================
                  /// FACTORIES
                  /// =========================
                  NavigationDestination(
                    icon: Icon(Iconsax.buildings_2, size: 22),

                    selectedIcon: Icon(
                      Iconsax.buildings_2,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),

                    label: AppTextStrings.factories,
                  ),

                  /// =========================
                  /// RECORDS
                  /// =========================
                  NavigationDestination(
                    icon: Icon(Iconsax.document_text, size: 22),

                    selectedIcon: Icon(
                      Iconsax.document_text,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),

                    label: AppTextStrings.records,
                  ),

                  /// =========================
                  /// REPORTS
                  /// =========================
                  NavigationDestination(
                    icon: Icon(Iconsax.receipt_text, size: 22),

                    selectedIcon: Icon(
                      Iconsax.receipt_text,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),

                    label: AppTextStrings.reports,
                  ),

                  /// =========================
                  /// SETTINGS
                  /// =========================
                  NavigationDestination(
                    icon: Icon(Iconsax.setting_2, size: 22),

                    selectedIcon: Icon(
                      Iconsax.setting_2,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),

                    label: AppTextStrings.more,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ======================================
/// CONTROLLER
/// ======================================

class NavigationController extends GetxController {
  /// Selected Index
  final Rx<int> selectedIndex = 0.obs;

  /// Update Index
  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  /// Screens
  final screens = [
    const Dashboard(),
    FactoryView(showBackArrow: false),
    const AllRecord(showBackArrow: false),
    ReportsScreen(),
    SettingsScreen(),
  ];
}
