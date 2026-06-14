import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text_strings.dart';
import 'term_and_condition_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              /// First Name
              Expanded(
                child: TextFormField(
                  expands: false,
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
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            decoration: InputDecoration(
              labelText: AppTextStrings.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            decoration: InputDecoration(
              labelText: AppTextStrings.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: AppTextStrings.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
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
              onPressed: () => Get.toNamed(AppRoutes.verifyEmail),
              child: Text(AppTextStrings.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
