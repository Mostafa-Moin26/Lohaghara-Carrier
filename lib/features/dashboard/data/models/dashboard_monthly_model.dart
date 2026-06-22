import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardMonthlyModel {
  final String monthKey;

  final double totalBilling;

  final int totalTrips;

  final double totalDemurrage;

  final int activeFactoryCount;

  final DateTime updatedAt;

  const DashboardMonthlyModel({
    required this.monthKey,
    required this.totalBilling,
    required this.totalTrips,
    required this.totalDemurrage,
    required this.activeFactoryCount,
    required this.updatedAt,
  });

  static DashboardMonthlyModel empty() => DashboardMonthlyModel(
    monthKey: '',
    totalBilling: 0,
    totalTrips: 0,
    totalDemurrage: 0,
    activeFactoryCount: 0,
    updatedAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      'MonthKey': monthKey,
      'TotalBilling': totalBilling,
      'TotalTrips': totalTrips,
      'TotalDemurrage': totalDemurrage,
      'ActiveFactoryCount': activeFactoryCount,
      'UpdatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory DashboardMonthlyModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    if (data == null) {
      return DashboardMonthlyModel.empty();
    }

    return DashboardMonthlyModel(
      monthKey: data['MonthKey'] ?? '',
      totalBilling: (data['TotalBilling'] ?? 0).toDouble(),
      totalTrips: data['TotalTrips'] ?? 0,
      totalDemurrage: (data['TotalDemurrage'] ?? 0).toDouble(),
      activeFactoryCount: data['ActiveFactoryCount'] ?? 0,
      updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),
    );
  }
}
