import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/delete_button.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_info.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_header.dart';
import 'package:lohaghara_carrier/features/profile/presentation/widgets/profile_tile.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    ProfileTile(
                      icon: Iconsax.user,
                      title: 'Full Name',
                      value: 'Mostafa Al Moin',
                    ),
                    ProfileTile(
                      icon: Iconsax.user,
                      title: 'Username',
                      value: 'moin26',
                    ),
                    ProfileTile(
                      icon: Icons.email,
                      title: 'Email',
                      value: 'mostafa.al.moin@example.com',
                    ),
                    ProfileTile(
                      icon: Iconsax.mobile,
                      title: 'Phone',
                      value: '01845664426',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
