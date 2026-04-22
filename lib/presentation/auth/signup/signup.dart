import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/styles/spacing_styles.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/presentation/auth/signup/widgets/signup_form.dart';

import '../../../core/common/widgets/login_signup/form_divider.dart';
import '../../../core/common/widgets/login_signup/social_buttons.dart';
import '../../../core/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: AppSpacingStyles.paddingWithAppBarHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(height: AppSizes.spaceBtwSections),

                /// Signup Text
                Text(
                  AppTextStrings.signUp,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Signup Form
                const SignupForm(),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Divider
                FormDivider(
                  dividerText: AppTextStrings.orSignUpWith.capitalize!,
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Social buttons
                const SocialButtons(),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Bottom text
                const Text(
                  AppTextStrings.copyrightText,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
