import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';

class DashboardStatsSkeleton extends StatelessWidget {
  const DashboardStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (_, _) {
            return const _DashboardCardSkeleton();
          },
        );
      },
    );
  }
}

class _DashboardCardSkeleton extends StatelessWidget {
  const _DashboardCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Icon
            ShimmerEffect(width: 36, height: 36, radius: 18),

            Spacer(),

            /// Title
            ShimmerEffect(width: 95, height: 14),

            SizedBox(height: 10),

            /// Value
            ShimmerEffect(width: 80, height: 22),

            SizedBox(height: 10),

            /// Subtitle
            ShimmerEffect(width: 60, height: 12),
          ],
        ),
      ),
    );
  }
}
