import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/chips/app_filter_chip.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/search_container.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/extensions/filter_type_extension.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/controller/reports_controller.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/widgets/report_card.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  final controller = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
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
              text: 'Search reports....',
              padding: EdgeInsets.only(bottom: AppSizes.md),
              // onTap: controller.updateSearch,
            ),

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
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.reports.length,
                  itemBuilder: (_, index) {
                    final report = controller.reports[index];

                    return ReportCard(
                      type: report["type"] as String,
                      title: report["title"] as String,
                      date: report["date"] as String,
                      billNo: report["billNo"] as String,
                      amount: report["amount"] as String,
                      trucks: report["trucks"] as String,
                      time: report["time"] as String,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
