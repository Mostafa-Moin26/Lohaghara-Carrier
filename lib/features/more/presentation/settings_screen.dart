import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/more/presentation/controller/settings_controller.dart';
import 'package:lohaghara_carrier/features/more/presentation/widgets/logout_button.dart';
import 'package:lohaghara_carrier/features/more/presentation/widgets/profile_card.dart';
import 'package:lohaghara_carrier/features/more/presentation/widgets/settings_section.dart';
import 'package:lohaghara_carrier/features/more/presentation/widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Settings'), showBackArrow: true),

      body: ListView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        children: [
          /// Profile
          const ProfileCard(),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Account
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon: Iconsax.user,
                title: 'Profile Information',
                subtitle: 'View and edit your profile',
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.security,
                title: 'Security',
                subtitle: 'Change password and settings',
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.wallet,
                title: 'Billing & Subscription',
                subtitle: 'Manage your billing',
                showBorder: false,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Preferences
          SettingsSection(
            title: 'Preferences',
            children: [
              Obx(
                () => SettingsTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  subtitle: 'Manage notification settings',

                  trailing: Switch(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                  ),
                ),
              ),

              Obx(
                () => SettingsTile(
                  icon: Iconsax.moon,
                  title: 'Dark Mode',
                  subtitle: 'Choose your preferred theme',

                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: controller.toggleDarkMode,
                  ),
                ),
              ),

              SettingsTile(
                icon: Iconsax.language_square,
                title: 'Language',
                subtitle: 'Change app language',

                trailing: Text(
                  'English',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                showBorder: false,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Support
          SettingsSection(
            title: 'Support',
            children: [
              SettingsTile(
                icon: Iconsax.message_question,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.message,
                title: 'Contact Support',
                subtitle: 'Reach out to our team',
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.info_circle,
                title: 'About App',
                subtitle: 'Learn more about Lohaghara Carrier',
                showBorder: false,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Logout
          const LogoutButton(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
