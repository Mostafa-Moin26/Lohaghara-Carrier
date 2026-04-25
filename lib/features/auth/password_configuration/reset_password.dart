import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';
import '../../../core/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Title and SubTitle
              Text(
                AppTextStrings.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTextStrings.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.createNewPassword),
                  child: Text(AppTextStrings.done),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Resend Email button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
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
