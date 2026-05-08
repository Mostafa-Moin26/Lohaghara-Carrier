import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stats_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/report_filters_section.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/summary_header_card.dart';
import 'package:lohaghara_carrier/core/common/widgets/floating/report_action_buttons.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final factoryController = Get.put(FactoryController());

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(AppTextStrings.summary),
        showBackArrow: true,
      ),

      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 MAIN CONTENT
            Column(
              children: [
                /// Top Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: Column(
                    children: const [
                      /// Filters
                      ReportFiltersSection(),
                      SizedBox(height: AppSizes.spaceBtwItems),

                      /// Header
                      SummaryHeaderCard(),
                      SizedBox(height: AppSizes.spaceBtwItems),

                      /// Stats
                      ReportStatsCard(
                        numOfTrucks: '131',
                        totalAmount: '৳23,19,300',
                      ),
                      SizedBox(height: AppSizes.spaceBtwItems),
                    ],
                  ),
                ),

                /// Factories Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: SectionHeading(
                    title: 'Factories',
                    onButtonPressed: () => Get.toNamed(AppRoutes.viewFactory),
                  ),
                ),

                const SizedBox(height: AppSizes.sm),

                /// Factory List
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      padding: const EdgeInsets.only(
                        left: AppSizes.defaultSpace,
                        right: AppSizes.defaultSpace,
                        bottom: 100, // 👈 prevents overlap
                      ),
                      itemCount: factoryController.factories.length,
                      itemBuilder: (_, index) {
                        final factory =
                            factoryController.factories[index]; // ✅ fixed

                        return FactoryCard(
                          name: factory["name"] as String,
                          trips: factory["trips"] as int,
                          amount: factory["amount"] as int,
                          onTap: () {
                            // TODO: navigate later
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            /// 🔥 FLOATING ACTION BUTTONS (Perfect Alignment)
            Positioned(
              left: AppSizes.defaultSpace,
              right: AppSizes.defaultSpace,
              bottom: 16,
              child: ReportActionButtons(
                onDownload: () {
                  // TODO: Download PDF
                },
                onShare: () {
                  // TODO: Share report
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
