import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lohaghara_carrier/core/common/styles/spacing_styles.dart';
import 'package:lohaghara_carrier/core/common/widgets/login_signup/form_divider.dart';
import 'package:lohaghara_carrier/core/common/widgets/login_signup/social_buttons.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/auth/presentation/login/widgets/login_form.dart';

import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacingStyles.paddingWithAppBarHeight,
            child: Column(
              children: [
                /// Logo & Title
                const LoginHeader(),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Login Text
                Text(
                  AppTextStrings.signIn,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                /// Login Form
                const LoginForm(),

                /// Divider
                FormDivider(
                  dividerText: AppTextStrings.orSignInWith.capitalize!,
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Social Buttons
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
