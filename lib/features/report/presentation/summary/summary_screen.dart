import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/floating/report_action_buttons.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stats_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/report_filters_section.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/summary_header_card.dart';
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
            /// 🔥 Main Scroll
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
                      children: const [
                        /// Filters
                        ReportFiltersSection(),
                        SizedBox(height: AppSizes.spaceBtwItems),

                        /// Header Card
                        SummaryHeaderCard(),
                        SizedBox(height: AppSizes.spaceBtwItems),

                        /// Stats Card
                        ReportStatsCard(
                          numOfTrucks: '131',
                          totalAmount: '৳23,19,300',
                        ),

                        SizedBox(height: AppSizes.spaceBtwItems),
                      ],
                    ),
                  ),
                ),

                /// =========================
                /// FACTORIES TITLE
                /// =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace,
                    ),

                    child: SectionHeading(
                      title: 'Factories',

                      onButtonPressed: () {
                        Get.toNamed(AppRoutes.viewFactory);
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sm)),

                /// =========================
                /// FACTORIES LIST
                /// =========================
                Obx(
                  () => SliverPadding(
                    padding: const EdgeInsets.only(
                      left: AppSizes.defaultSpace,
                      right: AppSizes.defaultSpace,
                      bottom: 120, // 👈 prevents FAB overlap
                    ),

                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((_, index) {
                        final factory = factoryController.factories[index];

                        return FactoryCard(
                          name: factory["name"] as String,
                          trips: factory["trips"] as int,
                          amount: factory["amount"] as int,
                          onTap: () {
                            // TODO: Navigate later
                          },
                        );
                      }, childCount: factoryController.factories.length),
                    ),
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
