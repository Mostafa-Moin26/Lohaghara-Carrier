import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: AppValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: AppTextStrings.email,
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        AppValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      labelText: AppTextStrings.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
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

                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailAndPasswordUser(),
                    child: const Text('Verify'),
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
