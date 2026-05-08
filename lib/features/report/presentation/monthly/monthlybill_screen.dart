import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/floating/report_action_buttons.dart';
import 'package:lohaghara_carrier/core/common/widgets/records/record_tile.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/report/presentation/monthly/widgets/filter_section.dart';
import 'package:lohaghara_carrier/features/report/presentation/monthly/widgets/monthly_header_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stats_card.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class MonthlybillScreen extends StatelessWidget {
  const MonthlybillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(AppTextStrings.monthlyBill),
        showBackArrow: true,
      ),

      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 MAIN CONTENT
            Column(
              children: [
                /// 🔹 TOP SECTION (NO Expanded here)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FiltersSection(),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      const MonthlyHeaderCard(),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      const ReportStatsCard(
                        numOfTrucks: '131',
                        totalAmount: '৳23,19,300',
                      ),

                      const SizedBox(height: AppSizes.spaceBtwItems),

                      SectionHeading(
                        title: AppTextStrings.tripRecords,
                        onButtonPressed: () =>
                            Get.toNamed(AppRoutes.allRecords),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.sm),

                /// 🔹 LIST SECTION
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: AppSizes.defaultSpace,
                      right: AppSizes.defaultSpace,
                      bottom: 100, // 👈 avoid overlap
                    ),
                    itemCount: 3,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSizes.spaceBtwItems),
                    itemBuilder: (context, index) {
                      return RecordTile(
                        truckNumber: 'DM TA-18-4209',
                        companyName: 'Meghna Knit Composite Ltd.',
                        amount: '15,500',
                        date: AppTextStrings.today,
                        onTap: () => Get.toNamed(AppRoutes.recordDetail),
                      );
                    },
                  ),
                ),
              ],
            ),

            /// 🔥 FLOATING BUTTONS
            Positioned(
              left: AppSizes.defaultSpace,
              right: AppSizes.defaultSpace,
              bottom: 16,
              child: ReportActionButtons(onDownload: () {}, onShare: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
