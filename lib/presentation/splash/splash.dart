import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/presentation/splash/controllers/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// main logo
            Image.asset(AppImageStrings.appLogo, width: 250, height: 250),

            /// loading animation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Lottie.asset(
                AppImageStrings.loadingIndicator,
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
