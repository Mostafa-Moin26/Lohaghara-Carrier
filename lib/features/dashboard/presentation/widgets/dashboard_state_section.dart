import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/dashboard_card.dart';

class DashboardStatsSection extends StatelessWidget {
  const DashboardStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Obx(() {
      final dashboard = controller.dashboard.value;

      return LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          double aspectRatio;

          if (screenWidth < 360) {
            aspectRatio = 1.0;
          } else if (screenWidth < 400) {
            aspectRatio = 1.15;
          } else {
            aspectRatio = 1.3;
          }

          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
            ),
            children: [
              DashboardStatCard(
                title: AppTextStrings.monthlyBilling,
                value: dashboard.totalBilling.toStringAsFixed(0),
                subtitle: controller.selectedMonthText,
                icon: Iconsax.wallet_money,
                iconColor: Colors.purple,
                isCurrency: true,
              ),

              DashboardStatCard(
                title: AppTextStrings.totalTrips,
                value: dashboard.totalTrips.toString(),
                subtitle: controller.selectedMonthText,
                icon: Iconsax.truck_fast,
                iconColor: Colors.blue,
              ),

              DashboardStatCard(
                title: AppTextStrings.totalFactories,
                value: dashboard.activeFactoryCount.toString(),
                subtitle: AppTextStrings.active,
                icon: Iconsax.buildings,
                iconColor: Colors.green,
              ),

              DashboardStatCard(
                title: AppTextStrings.totalDemurrage,
                value: dashboard.totalDemurrage.toStringAsFixed(0),
                subtitle: controller.selectedMonthText,
                icon: Iconsax.money_recive,
                iconColor: Colors.orange,
                isCurrency: true,
              ),
            ],
          );
        },
      );
    });
  }
}
