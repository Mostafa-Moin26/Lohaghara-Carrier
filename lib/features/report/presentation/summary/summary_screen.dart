import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/floating/report_action_buttons.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/section_heading.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stats_card.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/controller/summary_controller.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/report_filters_section.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/widgets/summary_header_card.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SummaryController());

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(AppTextStrings.summary),
        showBackArrow: true,
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              return RefreshIndicator(
                onRefresh: controller.refreshSummary,

                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),

                  slivers: [
                    /// =========================
                    /// Header Section
                    /// =========================
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            const ReportFiltersSection(),

                            const SizedBox(height: AppSizes.spaceBtwItems),

                            const SummaryHeaderCard(),

                            const SizedBox(height: AppSizes.spaceBtwItems),

                            ReportStatsCard(
                              numOfTrucks: controller.totalTrips.toString(),

                              totalAmount: controller.totalAmount
                                  .toStringAsFixed(0),
                            ),

                            const SizedBox(height: AppSizes.spaceBtwItems),
                          ],
                        ),
                      ),
                    ),

                    /// =========================
                    /// Factory Title
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

                    const SliverToBoxAdapter(
                      child: SizedBox(height: AppSizes.sm),
                    ),

                    /// =========================
                    /// Loading
                    /// =========================
                    if (controller.isLoading.value)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    /// =========================
                    /// Empty State
                    /// =========================
                    else if (controller.summaryFactories.isEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Center(
                            child: Text('No summary found for this month.'),
                          ),
                        ),
                      )
                    /// =========================
                    /// Factory List
                    /// =========================
                    else
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: AppSizes.defaultSpace,
                          right: AppSizes.defaultSpace,
                          bottom: 120,
                        ),

                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((_, index) {
                            final factory = controller.summaryFactories[index];

                            return FactoryCard(
                              companyName: factory.companyName,
                              name: factory.factoryName,
                              trips: factory.totalTrips,
                              amount: factory.totalAmount.toInt(),
                              onTap: () {
                                // Future
                              },
                            );
                          }, childCount: controller.summaryFactories.length),
                        ),
                      ),
                  ],
                ),
              );
            }),

            /// =========================
            /// Floating Buttons
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
