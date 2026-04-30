import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class PasswordResetSuccessful extends StatelessWidget {
  const PasswordResetSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  /// Icon
                  Image(
                    width: AppHelperFunctions.screenWidth() * 0.5,
                    image: AssetImage(AppImageStrings.passwordResetSuccessful),
                  ),

                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// Title
                  Text(
                    AppTextStrings.passwordResetSuccessSubtitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// SubTitle
                  Text(
                    AppTextStrings.passwordResetSuccessSubtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppSizes.spaceBtwSections * 5),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.offNamed(AppRoutes.login),
                      child: Text(AppTextStrings.backToLogin),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Lottie.asset(AppImageStrings.success),
        ],
      ),
    );
  }
}
