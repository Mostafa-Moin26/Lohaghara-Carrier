import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_model.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';

class MonthlyBillReportModel {
  final CompanyModel company;

  final FactoryModel factory;

  /// Example: 2026-06
  final String monthKey;

  /// Example: June 2026
  final DateTime month;

  final String billNo;

  final List<RecordModel> records;

  final int totalTrips;

  final double totalAmount;

  final String amountInWords;

  const MonthlyBillReportModel({
    required this.company,
    required this.factory,
    required this.monthKey,
    required this.month,
    required this.billNo,
    required this.records,
    required this.totalTrips,
    required this.totalAmount,
    required this.amountInWords,
  });

  MonthlyBillReportModel copyWith({
    CompanyModel? company,
    FactoryModel? factory,
    String? monthKey,
    DateTime? month,
    String? billNo,
    List<RecordModel>? records,
    int? totalTrips,
    double? totalAmount,
    String? amountInWords,
  }) {
    return MonthlyBillReportModel(
      company: company ?? this.company,
      factory: factory ?? this.factory,
      monthKey: monthKey ?? this.monthKey,
      month: month ?? this.month,
      billNo: billNo ?? this.billNo,
      records: records ?? this.records,
      totalTrips: totalTrips ?? this.totalTrips,
      totalAmount: totalAmount ?? this.totalAmount,
      amountInWords: amountInWords ?? this.amountInWords,
    );
  }

  static MonthlyBillReportModel empty() {
    return MonthlyBillReportModel(
      company: CompanyModel.empty(),
      factory: FactoryModel.empty(),
      monthKey: '',
      month: DateTime.now(),
      billNo: '',
      records: const [],
      totalTrips: 0,
      totalAmount: 0,
      amountInWords: '',
    );
  }
}
