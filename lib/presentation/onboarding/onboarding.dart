import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/device/device_utility.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/presentation/onboarding/controllers/onboarding_controller.dart';
import 'package:lohaghara_carrier/presentation/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:lohaghara_carrier/presentation/onboarding/widgets/onboarding_next_button.dart';
import 'package:lohaghara_carrier/presentation/onboarding/widgets/onboarding_page.dart';
import 'package:lohaghara_carrier/presentation/onboarding/widgets/onboarding_skip.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          /// Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppImageStrings.onBoardingImage1,
                title: AppTextStrings.onBoardingTitle1,
                subTitle: AppTextStrings.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AppImageStrings.onBoardingImage2,
                title: AppTextStrings.onBoardingTitle2,
                subTitle: AppTextStrings.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: AppImageStrings.onBoardingImage3,
                title: AppTextStrings.onBoardingTitle3,
                subTitle: AppTextStrings.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Dot Indicator
          const OnBoardinDotNavigation(),

          /// Bottom Container
          Positioned(
            bottom: DeviceUtils.getBottomNavigationBarHeight(),
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace,
              ),
              child: Obx(() {
                final isLastPage = controller.isLastPage;

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    key: ValueKey(isLastPage),
                    height: 65,
                    child: isLastPage
                        ? Material(
                            color: AppColors.primaryColor,
                            shape: const StadiumBorder(),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: controller.finishOnboarding,
                              child: const Center(
                                child: Text(
                                  AppTextStrings.getstarted,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Material(
                            color: dark
                                ? AppColors.darkerGrey
                                : AppColors.white,

                            shape: const StadiumBorder(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.md,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Skip Button
                                  OnBoardingSkip(),

                                  /// Next Button
                                  OnBoardingNextButton(),
                                ],
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
