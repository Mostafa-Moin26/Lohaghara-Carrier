import 'package:lohaghara_carrier/features/company/data/models/company_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';

class SummaryReportModel {
  final CompanyModel company;

  /// Example: 2026-06
  final String monthKey;

  /// Example: June 2026
  final DateTime month;

  final String billNo;

  final List<FactoryMonthlyModel> factories;

  final int totalTrips;

  final double totalAmount;

  final String amountInWords;

  const SummaryReportModel({
    required this.company,
    required this.monthKey,
    required this.month,
    required this.billNo,
    required this.factories,
    required this.totalTrips,
    required this.totalAmount,
    required this.amountInWords,
  });

  SummaryReportModel copyWith({
    CompanyModel? company,
    String? monthKey,
    DateTime? month,
    String? billNo,
    List<FactoryMonthlyModel>? factories,
    int? totalTrips,
    double? totalAmount,
    String? amountInWords,
  }) {
    return SummaryReportModel(
      company: company ?? this.company,
      monthKey: monthKey ?? this.monthKey,
      month: month ?? this.month,
      billNo: billNo ?? this.billNo,
      factories: factories ?? this.factories,
      totalTrips: totalTrips ?? this.totalTrips,
      totalAmount: totalAmount ?? this.totalAmount,
      amountInWords: amountInWords ?? this.amountInWords,
    );
  }

  static SummaryReportModel empty() {
    return SummaryReportModel(
      company: CompanyModel.empty(),
      monthKey: '',
      month: DateTime.now(),
      billNo: '',
      factories: const [],
      totalTrips: 0,
      totalAmount: 0,
      amountInWords: '',
    );
  }

  bool get hasData => factories.isNotEmpty;

  int get totalFactories => factories.length;

  bool get isEmpty => factories.isEmpty;
}
