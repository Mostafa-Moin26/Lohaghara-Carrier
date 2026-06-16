import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/controller/forget_password_controller.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// lottie animation with 60% of screen width
              Lottie.asset(
                AppImageStrings.emailSuccessfullySent,
                width: AppHelperFunctions.screenWidth() * 0.6,
              ),

              /// Email
              Text(
                email ?? 'Email not provided',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Title and SubTitle
              Text(
                AppTextStrings.changePasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTextStrings.changePasswordSubtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Get.toNamed(AppRoutes.passwordResetSuccessful),
                  child: Text(AppTextStrings.done),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Resend Email button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance
                      .resendPasswordResetEmail(email ?? ''),
                  child: Text(AppTextStrings.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
