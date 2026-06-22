import 'package:cloud_firestore/cloud_firestore.dart';

class FactoryMonthlyModel {
  final String factoryId;

  final String factoryName;

  final String companyId;

  final String companyName;

  final String monthKey;

  final int totalTrips;

  final double totalAmount;

  final DateTime updatedAt;

  const FactoryMonthlyModel({
    required this.factoryId,
    required this.factoryName,
    required this.companyId,
    required this.companyName,
    required this.monthKey,
    required this.totalTrips,
    required this.totalAmount,
    required this.updatedAt,
  });

  static FactoryMonthlyModel empty() => FactoryMonthlyModel(
    factoryId: '',
    factoryName: '',
    companyId: '',
    companyName: '',
    monthKey: '',
    totalTrips: 0,
    totalAmount: 0,
    updatedAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      'FactoryId': factoryId,
      'FactoryName': factoryName,
      'CompanyId': companyId,
      'CompanyName': companyName,
      'MonthKey': monthKey,
      'TotalTrips': totalTrips,
      'TotalAmount': totalAmount,
      'UpdatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
