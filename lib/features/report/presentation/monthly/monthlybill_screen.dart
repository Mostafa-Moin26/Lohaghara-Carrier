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
            /// 🔥 MAIN SCROLL
            CustomScrollView(
              slivers: [
                /// =========================
                /// TOP SECTION
                /// =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// Filters
                        const FiltersSection(),
                        const SizedBox(height: AppSizes.spaceBtwItems),

                        /// Header Card
                        const MonthlyHeaderCard(),
                        const SizedBox(height: AppSizes.spaceBtwItems),

                        /// Stats Card
                        const ReportStatsCard(
                          numOfTrucks: '131',
                          totalAmount: '৳23,19,300',
                        ),

                        const SizedBox(height: AppSizes.spaceBtwItems),

                        /// Section Heading
                        SectionHeading(
                          title: AppTextStrings.tripRecords,

                          onButtonPressed: () {
                            Get.toNamed(AppRoutes.allRecords);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sm)),

                /// =========================
                /// RECORDS LIST
                /// =========================
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.defaultSpace,
                    right: AppSizes.defaultSpace,
                    bottom: 120, // 👈 FAB overlap protection
                  ),

                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBtwItems,
                        ),

                        child: RecordTile(
                          truckNumber: 'DM TA-18-4209',

                          companyName: 'Meghna Knit Composite Ltd.',

                          amount: '15,500',

                          date: AppTextStrings.today,

                          onTap: () {
                            Get.toNamed(AppRoutes.recordDetail);
                          },
                        ),
                      );
                    }, childCount: 3),
                  ),
                ),
              ],
            ),

            /// =========================
            /// FLOATING ACTION BUTTONS
            /// =========================
            Positioned(
              left: AppSizes.defaultSpace,
              right: AppSizes.defaultSpace,
              bottom: 16,

              child: ReportActionButtons(
                onDownload: () {
                  // TODO: Download PDF
                },

                onShare: () {
                  // TODO: Share Report
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
