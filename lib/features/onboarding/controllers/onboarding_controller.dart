import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Controller
  final pageController = PageController();

  /// Current page index
  Rx<int> currentPageIndex = 0.obs;

  /// Total pages
  final int totalPages = 3;

  /// Update index when page changes
  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  /// Dot navigation
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Next button
  void nextPage() {
    if (isLastPage) {
      finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Skip button → go to last page
  void skipPage() {
    pageController.animateToPage(
      totalPages - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Check last page
  bool get isLastPage => currentPageIndex.value == totalPages - 1;

  /// Finish onboarding
  void finishOnboarding() {
    final storage = GetStorage();

    storage.write('IsFirstTime', false);
    Get.offNamed(AppRoutes.login);
  }
}
