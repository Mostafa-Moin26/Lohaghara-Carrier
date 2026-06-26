import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/common/widgets/loaders/recent_records_skeleton.dart';

import 'package:lohaghara_carrier/core/common/widgets/records/record_tile.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class RecentRecordsSection extends StatelessWidget {
  const RecentRecordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Obx(() {
      if (controller.isLoading.value) {
        return const RecentRecordsSkeleton();
      }

      final records = controller.recentRecords;

      if (records.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(child: Text('No records found for this month')),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: records.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final record = records[index];

          return RecordTile(
            truckNumber: record.truckNumber,

            companyName: record.factoryName,

            amount: record.totalAmount.toStringAsFixed(0),

            date: DateFormat('dd MMM yyyy').format(record.date),

            onTap: () {
              Get.toNamed(AppRoutes.recordDetail, arguments: record);
            },
          );
        },
      );
    });
  }
}
