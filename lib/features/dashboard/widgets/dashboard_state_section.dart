import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/widgets/dashboard_card.dart';

class DashboardStatsSection extends StatelessWidget {
  const DashboardStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        double aspectRatio;

        /// Small phones
        if (screenWidth < 360) {
          aspectRatio = 1.0;
        }
        /// Medium phones
        else if (screenWidth < 400) {
          aspectRatio = 1.15;
        }
        /// Large phones
        else {
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
          children: const [
            DashboardStatCard(
              title: AppTextStrings.monthlyBilling,
              value: "16,99,500",
              subtitle: AppTextStrings.thisMonth,
              icon: Iconsax.wallet_money,
              iconColor: Colors.purple,
              isCurrency: true,
            ),

            DashboardStatCard(
              title: AppTextStrings.totalTrips,
              value: "110",
              subtitle: AppTextStrings.thisMonth,
              icon: Iconsax.truck_fast,
              iconColor: Colors.blue,
            ),

            DashboardStatCard(
              title: AppTextStrings.totalFactories,
              value: "4",
              subtitle: AppTextStrings.active,
              icon: Iconsax.buildings,
              iconColor: Colors.green,
            ),

            DashboardStatCard(
              title: AppTextStrings.totalDemurrage,
              value: "1,05,000",
              subtitle: AppTextStrings.thisMonth,
              icon: Iconsax.money_recive,
              iconColor: Colors.orange,
              isCurrency: true,
            ),
          ],
        );
      },
    );
  }
}
