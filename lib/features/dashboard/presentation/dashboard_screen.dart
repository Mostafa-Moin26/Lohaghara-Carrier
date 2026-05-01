import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/dashboard_state_section.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/month_selector.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/quick_action_section.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/recent_records_section.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import 'widgets/dashboard_header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSizes.md,
              left: AppSizes.defaultSpace,
              right: AppSizes.defaultSpace,
              bottom: AppSizes.defaultSpace,
            ),
            child: Column(
              children: [
                /// Header
                DashBoardHeader(),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Month selector
                MonthSelector(),
                const SizedBox(height: AppSizes.lg),

                /// Monthly Billing, Total Trips, Total Factories, Total Demurrage
                DashboardStatsSection(),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Quick Actions
                SectionHeading(
                  title: AppTextStrings.quickActions,
                  showActionButton: false,
                ),
                QuickActionsSection(),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Recent Records
                SectionHeading(
                  title: AppTextStrings.recentRecords,
                  showActionButton: true,
                  onButtonPressed: () => Get.toNamed(AppRoutes.allRecords),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                RecentRecordsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
