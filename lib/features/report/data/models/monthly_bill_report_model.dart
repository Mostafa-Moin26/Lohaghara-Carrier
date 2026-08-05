import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/report/data/models/monthy_bill_record_model.dart';

class MonthlyBillReportModel {
  final FactoryModel factory;

  /// Example: 2026-06
  final String monthKey;

  /// Example: June 2026
  final DateTime month;

  final String billNo;

  final List<MonthlyBillRecordModel> records;

  /// Total Trucks
  final int totalTrips;

  /// Grand Total Amount
  final double grandTotal;

  final String amountInWords;

  const MonthlyBillReportModel({
    required this.factory,
    required this.monthKey,
    required this.month,
    required this.billNo,
    required this.records,
    required this.totalTrips,
    required this.grandTotal,
    required this.amountInWords,
  });

  MonthlyBillReportModel copyWith({
    FactoryModel? factory,
    String? monthKey,
    DateTime? month,
    String? billNo,
    List<MonthlyBillRecordModel>? records,
    int? totalTrips,
    double? grandTotal,
    String? amountInWords,
  }) {
    return MonthlyBillReportModel(
      factory: factory ?? this.factory,
      monthKey: monthKey ?? this.monthKey,
      month: month ?? this.month,
      billNo: billNo ?? this.billNo,
      records: records ?? this.records,
      totalTrips: totalTrips ?? this.totalTrips,
      grandTotal: grandTotal ?? this.grandTotal,
      amountInWords: amountInWords ?? this.amountInWords,
    );
  }

  static MonthlyBillReportModel empty() {
    return MonthlyBillReportModel(
      factory: FactoryModel.empty(),
      monthKey: '',
      month: DateTime.now(),
      billNo: '',
      records: const [],
      totalTrips: 0,
      grandTotal: 0,
      amountInWords: '',
    );
  }
}
