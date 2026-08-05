import 'package:lohaghara_carrier/core/helpers/amount_in_words_helper.dart';

import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';

import 'package:lohaghara_carrier/features/report/data/models/monthly_bill_report_model.dart';
import 'package:lohaghara_carrier/features/report/data/models/monthy_bill_record_model.dart';

class MonthlyReportBuilder {
  MonthlyReportBuilder._();

  //==========================================================
  // Build Monthly Report
  //==========================================================

  static MonthlyBillReportModel build({
    required FactoryModel factory,
    required FactoryMonthlyModel factoryMonthly,
    required List<MonthlyBillRecordModel> records,
    required DateTime month,
    required String monthKey,
    required String billNo,
  }) {
    return MonthlyBillReportModel(
      factory: factory,

      month: month,

      monthKey: monthKey,

      billNo: billNo,

      records: List<MonthlyBillRecordModel>.from(records),

      totalTrips: factoryMonthly.totalTrips,

      grandTotal: factoryMonthly.totalAmount,

      amountInWords: AmountInWordsHelper.convert(factoryMonthly.totalAmount),
    );
  }
}
