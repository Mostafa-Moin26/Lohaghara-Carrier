import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';

class ReportActionButtons extends StatelessWidget {
  const ReportActionButtons({
    super.key,
    required this.onDownload,
    required this.onShare,
  });

  final VoidCallback onDownload;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
      child: Row(
        children: [
          /// 🔹 Download Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onDownload,
              icon: const Icon(Icons.download),
              label: const Text(AppTextStrings.download),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 6,
              ),
            ),
          ),

          const SizedBox(width: AppSizes.sm),

          /// 🔹 Share Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onShare,
              icon: const Icon(Icons.share),
              label: const Text(AppTextStrings.share),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
