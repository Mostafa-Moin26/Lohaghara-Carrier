import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/colors.dart';
import '../../../core/device/device_utility.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardinDotNavigation extends StatelessWidget {
  const OnBoardinDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 120,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ScrollingDotsEffect(
            activeDotColor: AppColors.primaryColor,
            dotColor: Colors.grey.shade500,
            dotWidth: 8,
            dotHeight: 8,
            spacing: 8,
            activeDotScale: 1.4,
          ),
        ),
      ),
    );
  }
}
