import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/dashboard/widgets/month_selector.dart';

import 'widgets/dashboard_header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                /// Header
                DashBoardHeader(),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Month selector
                MonthSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
