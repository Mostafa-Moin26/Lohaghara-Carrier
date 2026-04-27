import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/auth/password_configuration/widgets/text_with_verify_icon.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import '../../../core/constants/image_strings.dart';
import '../../../core/constants/text_strings.dart';
import '../../../core/helpers/helper_functions.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Icon
                Image(
                  width: AppHelperFunctions.screenWidth() * 0.35,
                  image: AssetImage(AppImageStrings.createNewPassIcon),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Headings
                Text(
                  AppTextStrings.createNewPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  textAlign: TextAlign.center,
                  AppTextStrings.createNewPasswordSubTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// new password
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: AppTextStrings.newPassword,
                    suffixIcon: Icon(Iconsax.eye_slash),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                /// confirm password
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: AppTextStrings.confirmNewPassword,
                    suffixIcon: Icon(Iconsax.eye_slash),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections * 1.5),

                /// Password Requirement texts
                TextWithVerifyIcon(
                  text: AppTextStrings.passwordRequirementText1,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                TextWithVerifyIcon(
                  text: AppTextStrings.passwordRequirementText2,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                TextWithVerifyIcon(
                  text: AppTextStrings.passwordRequirementText3,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections * 2),

                /// Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.passwordResetSuccessful),
                    child: Text(AppTextStrings.resetPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
