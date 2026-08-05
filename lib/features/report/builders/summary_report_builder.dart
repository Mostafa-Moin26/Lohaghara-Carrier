import 'package:lohaghara_carrier/core/helpers/amount_in_words_helper.dart';

import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';

import 'package:lohaghara_carrier/features/report/data/models/summary_report_model.dart';

class SummaryReportBuilder {
  SummaryReportBuilder._();

  //==========================================================
  // Build Summary Report
  //==========================================================

  static SummaryReportModel build({
    required CompanyModel company,
    required List<FactoryMonthlyModel> factories,
    required DateTime month,
    required String monthKey,
    required String billNo,
  }) {
    final totalTrips = factories.fold<int>(
      0,
      (sum, item) => sum + item.totalTrips,
    );

    final totalAmount = factories.fold<double>(
      0,
      (sum, item) => sum + item.totalAmount,
    );

    return SummaryReportModel(
      company: company,

      month: month,

      monthKey: monthKey,

      billNo: billNo,

      factories: List<FactoryMonthlyModel>.from(factories),

      totalTrips: totalTrips,

      totalAmount: totalAmount,

      amountInWords: AmountInWordsHelper.convert(totalAmount),
    );
  }
}
