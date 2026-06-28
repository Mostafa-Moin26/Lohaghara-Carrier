import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/popups/loaders.dart';
import 'package:lohaghara_carrier/core/utils/date_formatter.dart';
import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/report/presentation/summary/controller/summary_controller.dart';
import 'package:lohaghara_carrier/features/report/services/pdf/summary_pdf_service.dart';
import 'package:printing/printing.dart';

class ReportFiltersSection extends StatelessWidget {
  const ReportFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = SummaryController.instance;

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= Company =================
          Text(
            AppTextStrings.company,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: AppSizes.sm),

          Obx(
            () => DropdownButtonFormField<CompanyModel>(
              initialValue: controller.selectedCompany.value,
              isExpanded: true,
              icon: const Icon(Iconsax.arrow_down_1),

              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.building_3),

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  borderSide: BorderSide(
                    color: dark ? AppColors.grey : AppColors.primaryDark,
                  ),
                ),
              ),

              items: controller.companies.map((company) {
                return DropdownMenuItem<CompanyModel>(
                  value: company,
                  child: Text(company.name, overflow: TextOverflow.ellipsis),
                );
              }).toList(),

              onChanged: (company) {
                if (company != null) {
                  controller.updateSelectedCompany(company);
                }
              },
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          /// ================= Month =================
          Text(
            AppTextStrings.month,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: AppSizes.sm),

          Obx(
            () => _selectionBox(
              context,
              icon: Iconsax.calendar,
              title: DateFormatter.monthYear(controller.selectedMonth.value),
              onTap: () => controller.pickMonth(context),
              showDownArrow: true,
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          /// ================= Generate Button =================
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (controller.summaryFactories.isEmpty) {
                  AppLoaders.warningSnackBar(
                    title: 'No Data Found',
                    message:
                        'No summary data is available for the selected company and month.',
                  );
                  return;
                }

                final pdfBytes = await SummaryPdfService.generate(
                  report: controller.report.value,
                );

                await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
              },
              icon: const Icon(Iconsax.chart_21),
              label: const Text(AppTextStrings.generateReport),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= Selection Box =================
  Widget _selectionBox(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool showDownArrow,
  }) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          border: Border.all(
            color: dark ? AppColors.grey : AppColors.primaryDark,
          ),
        ),
        child: Row(
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: dark
                    ? AppColors.primaryLight.withValues(alpha: .10)
                    : AppColors.primaryColor.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: AppSizes.iconSm,
                color: dark ? AppColors.primaryLight : AppColors.primaryColor,
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            /// Title
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            if (showDownArrow)
              const Icon(Iconsax.arrow_down_1, size: AppSizes.iconSm),
          ],
        ),
      ),
    );
  }
}
