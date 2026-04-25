import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
        () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.updateIndex(index),
          backgroundColor: dark ? AppColors.black : AppColors.white,
          indicatorColor: dark
              ? AppColors.white.withValues(alpha: 0.1)
              : AppColors.black.withValues(alpha: 0.1),
          destinations: [
            const NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Dashboard',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.buildings_2),
              label: 'Factories',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.document_text),
              label: 'Records',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.receipt_text),
              label: 'Reports',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.setting_2),
              label: 'More',
            ),
          ],
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
    Center(child: Text('Dashboard')),
    Center(child: Text('Factories')),
    Center(child: Text('Records')),
    Center(child: Text('Reports')),
    Center(child: Text('More')),
  ];
}
