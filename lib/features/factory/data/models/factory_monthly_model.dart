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

  FactoryMonthlyModel copyWith({
    String? factoryId,
    String? factoryName,
    String? companyId,
    String? companyName,
    String? monthKey,
    int? totalTrips,
    double? totalAmount,
    DateTime? updatedAt,
  }) {
    return FactoryMonthlyModel(
      factoryId: factoryId ?? this.factoryId,
      factoryName: factoryName ?? this.factoryName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      monthKey: monthKey ?? this.monthKey,
      totalTrips: totalTrips ?? this.totalTrips,
      totalAmount: totalAmount ?? this.totalAmount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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

  factory FactoryMonthlyModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return FactoryMonthlyModel(
        factoryId: data['FactoryId'] ?? '',
        factoryName: data['FactoryName'] ?? '',
        companyId: data['CompanyId'] ?? '',
        companyName: data['CompanyName'] ?? '',
        monthKey: data['MonthKey'] ?? '',
        totalTrips: data['TotalTrips'] ?? 0,
        totalAmount: (data['TotalAmount'] ?? 0).toDouble(),
        updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),
      );
    }

    return FactoryMonthlyModel.empty();
  }
}
