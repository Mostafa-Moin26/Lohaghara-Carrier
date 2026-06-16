import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/controller/forget_password_controller.dart';

import '../../../../../core/common/widgets/containers/rounded_container.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Icon
                Image(
                  width: AppHelperFunctions.screenWidth() * 0.35,
                  image: AssetImage(AppImageStrings.forgotPassIcon),
                ),

                /// Headings
                Text(
                  AppTextStrings.forgotPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  textAlign: TextAlign.center,
                  AppTextStrings.forgotPasswordSubtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Text field
                Form(
                  key: controller.forgetPasswordFormKey,
                  child: TextFormField(
                    controller: controller.email,
                    validator: AppValidator.validateEmail,
                    decoration: InputDecoration(
                      labelText: AppTextStrings.email,
                      prefixIcon: const Icon(Iconsax.direct_right),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Send Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(AppTextStrings.sendResetLink),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Additional text container
                RoundedContainer(
                  title: AppTextStrings.checkInbox,
                  icon: Iconsax.directbox_notif,
                  subTitle: AppTextStrings.sentResetLinkToEmail,
                  showSubTitle: true,
                  showButton: false,
                ),
                const SizedBox(height: AppSizes.sm),
                RoundedContainer(
                  title: AppTextStrings.didntReceiveIt,
                  icon: Iconsax.message_question,
                  subTitle: AppTextStrings.checkSpam,
                  showSubTitle: true,
                  showButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text(
            AppTextStrings.backToLogin,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: AppColors.primaryDark),
          ),
        ),
      ),
    );
  }
}
