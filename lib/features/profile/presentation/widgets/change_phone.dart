import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/update_phone_controller.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Change Phone Number',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Use real phone number for easy verification. This number will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Text field and Button
            Form(
              key: controller.updatePhoneFormKey,
              child: Column(
                children: [
                  /// Phone Number
                  TextFormField(
                    controller: controller.phone,
                    validator: (value) =>
                        AppValidator.validateEmptyText('Phone number', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Iconsax.call),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserPhone(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
