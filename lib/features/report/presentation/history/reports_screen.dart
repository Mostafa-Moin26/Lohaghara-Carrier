import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/chips/app_filter_chip.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/search_container.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/extensions/filter_type_extension.dart';
import 'package:lohaghara_carrier/features/company/data/repositories/company_repository.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/controller/reports_controller.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/widgets/report_card.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  final controller = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    Get.put(CompanyRepository());
    final searchController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: const Text(AppTextStrings.reports)),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace,
          vertical: AppSizes.sm,
        ),
        child: Column(
          children: [
            /// 🔍 Search
            SearchContainer(
              controller: searchController,
              hintText: 'Search reports...',
              onChanged: controller.updateSearch,
            ),
            const SizedBox(height: AppSizes.md),

            /// 🎯 Filters
            Obx(() {
              return SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.filters.map((filter) {
                      final selected =
                          controller.selectedFilter.value == filter;

                      return AppFilterChip(
                        title: filter.title,
                        isSelected: selected,
                        onTap: () => controller.updateFilter(filter),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// 📄 List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.reports.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.refresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(
                          height: 300,
                          child: Center(child: Text('No reports found')),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refresh,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.reports.length,
                    itemBuilder: (_, index) {
                      final report = controller.reports[index];

                      return ReportCard(
                        report: report,
                        onDelete: () {
                          controller.deleteReport(report.id);
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
