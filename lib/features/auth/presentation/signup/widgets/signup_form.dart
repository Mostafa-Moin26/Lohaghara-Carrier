import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';
import 'package:lohaghara_carrier/features/auth/presentation/signup/controller/signup_controller.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';
import 'term_and_condition_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              /// First Name
              Expanded(
                child: TextFormField(
                  expands: false,
                  controller: controller.firstName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('First Name', value),
                  decoration: InputDecoration(
                    labelText: AppTextStrings.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),

              const SizedBox(width: AppSizes.spaceBtwInputFields),

              /// Last Name
              Expanded(
                child: TextFormField(
                  expands: false,
                  controller: controller.lastName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Last Name', value),
                  decoration: InputDecoration(
                    labelText: AppTextStrings.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            decoration: InputDecoration(
              labelText: AppTextStrings.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
            controller: controller.username,
            validator: (value) =>
                AppValidator.validateEmptyText('Username', value),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            decoration: InputDecoration(
              labelText: AppTextStrings.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            decoration: InputDecoration(
              labelText: AppTextStrings.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => AppValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppTextStrings.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.toggle(),
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Terms & Conditions checkbox
          const TermsAndConditionCheckbox(),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(AppTextStrings.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
