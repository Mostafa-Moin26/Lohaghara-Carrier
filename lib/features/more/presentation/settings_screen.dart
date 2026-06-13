import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
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
      appBar: CustomAppBar(title: const Text(AppTextStrings.settings)),

      body: ListView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        children: [
          /// Profile
          const ProfileCard(),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Account
          SettingsSection(
            title: AppTextStrings.account,
            children: [
              SettingsTile(
                icon: Iconsax.user,
                title: AppTextStrings.profileInformation,
                subtitle: AppTextStrings.viewAndEditProfile,
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.security,
                title: AppTextStrings.security,
                subtitle: AppTextStrings.changePasswordAndSettings,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Preferences
          SettingsSection(
            title: AppTextStrings.preferences,
            children: [
              Obx(
                () => SettingsTile(
                  icon: Iconsax.notification,
                  title: AppTextStrings.notifications,
                  subtitle: AppTextStrings.manageNotificationSettings,

                  trailing: Switch(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                  ),
                ),
              ),

              Obx(
                () => SettingsTile(
                  icon: Iconsax.moon,
                  title: AppTextStrings.darkMode,
                  subtitle: AppTextStrings.preferredTheme,

                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: controller.toggleDarkMode,
                  ),
                ),
              ),

              SettingsTile(
                icon: Iconsax.language_square,
                title: AppTextStrings.language,
                subtitle: AppTextStrings.changeAppLanguage,

                trailing: Text(
                  AppTextStrings.english,
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
            title: AppTextStrings.support,
            children: [
              SettingsTile(
                icon: Iconsax.message_question,
                title: AppTextStrings.helpCenter,
                subtitle: AppTextStrings.getHelpAndSupport,
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.message,
                title: AppTextStrings.contactSupport,
                subtitle: AppTextStrings.reachOutTeam,
                onTap: () {},
              ),

              SettingsTile(
                icon: Iconsax.info_circle,
                title: AppTextStrings.aboutApp,
                subtitle: AppTextStrings.learnMoreAboutApp,
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
