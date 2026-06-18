import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/update_name_controller.dart';
import 'package:lohaghara_carrier/features/profile/presentation/controller/user_controller.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/change_name.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/change_phone.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/delete_button.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_info.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_header.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_tile.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateNameController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: const Text('Profile Details'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace,
            ),
            child: Column(
              children: [
                /// Header
                ProfileHeader(),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Personal Information
                ProfileInfoSection(
                  title: 'Personal Information',
                  children: [
                    Obx(
                      () => ProfileTile(
                        icon: Iconsax.user,
                        title: 'Full Name',
                        value: UserController.instance.user.value.fullName,
                        onTap: () => Get.to(() => ChangeName()),
                      ),
                    ),
                    ProfileTile(
                      icon: Iconsax.user,
                      title: 'Username',
                      value: UserController.instance.user.value.username,
                    ),
                    ProfileTile(
                      icon: Icons.email,
                      title: 'Email',
                      value: UserController.instance.user.value.email,
                    ),
                    Obx(
                      () => ProfileTile(
                        icon: Iconsax.mobile,
                        title: 'Phone',
                        value: UserController.instance.user.value.phoneNumber,
                        onTap: () => Get.to(() => ChangePhone()),
                      ),
                    ),
                    ProfileTile(
                      icon: Iconsax.briefcase,
                      title: 'Role',
                      value: 'Admin',
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Delete Account
                DeleteAccountButton(),

                const SizedBox(height: AppSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
