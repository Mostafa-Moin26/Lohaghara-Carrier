import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/floating/report_action_buttons.dart';
import 'package:lohaghara_carrier/core/common/widgets/records/record_tile.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/formatters/formatter.dart';
import 'package:lohaghara_carrier/features/report/presentation/monthly/widgets/filter_section.dart';
import 'package:lohaghara_carrier/features/report/presentation/monthly/widgets/monthly_header_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stats_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/controller/monthly_bill_controller.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

import '../../data/repositories/report_repository.dart';

class MonthlybillScreen extends StatelessWidget {
  const MonthlybillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MonthlyBillController.instance;
    Get.put(ReportRepository());
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
                        Obx(
                          () => ReportStatsCard(
                            numOfTrucks: controller
                                .factoryMonthly
                                .value
                                .totalTrips
                                .toString(),
                            totalAmount: controller
                                .factoryMonthly
                                .value
                                .totalAmount
                                .toString(),
                          ),
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
                Obx(() {
                  if (controller.previewRecords.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text('No trip records found.'),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      final record = controller.previewRecords[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBtwItems,
                        ),
                        child: RecordTile(
                          truckNumber: record.truckNumber,

                          // Monthly Report Screen-এ Company name-এর পরিবর্তে
                          // Unload Point দেখানো বেশি useful হবে
                          companyName: record.unloadPoint,

                          amount: record.totalAmount.toString(),

                          date: AppFormatter.formatDate(record.date),

                          onTap: () {
                            // পরে Full Record Details screen-এ নিয়ে যাবো
                          },
                        ),
                      );
                    }, childCount: controller.previewRecords.length),
                  );
                }),
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
                  controller.downloadPdf();
                },

                onShare: () {
                  controller.sharePdf();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
