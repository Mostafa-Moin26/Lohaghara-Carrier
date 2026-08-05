import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  const ReportModel({
    required this.id,
    required this.reportType,

    required this.companyId,
    required this.companyName,

    this.factoryId,
    this.factoryName,

    required this.month,
    required this.monthKey,

    required this.billNo,

    required this.totalTrips,
    required this.totalAmount,

    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  //==========================================================
  // Basic
  //==========================================================

  final String id;

  /// summary / monthly
  final String reportType;

  //==========================================================
  // Company
  //==========================================================

  final String companyId;
  final String companyName;

  //==========================================================
  // Factory (Nullable for Summary Report)
  //==========================================================

  final String? factoryId;
  final String? factoryName;

  //==========================================================
  // Report Info
  //==========================================================

  final DateTime month;

  /// Example : 2026-06
  final String monthKey;

  final String billNo;

  //==========================================================
  // Statistics
  //==========================================================

  final int totalTrips;

  final double totalAmount;

  //==========================================================
  // Audit
  //==========================================================

  final DateTime createdAt;

  final DateTime updatedAt;

  final String createdBy;

  //==========================================================
  // Empty
  //==========================================================

  static ReportModel empty() => ReportModel(
    id: '',
    reportType: '',

    companyId: '',
    companyName: '',

    factoryId: null,
    factoryName: null,

    month: DateTime.now(),
    monthKey: '',

    billNo: '',

    totalTrips: 0,
    totalAmount: 0,

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    createdBy: '',
  );

  //==========================================================
  // From Snapshot
  //==========================================================

  factory ReportModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (!document.exists) return ReportModel.empty();

    final data = document.data()!;

    return ReportModel(
      id: document.id,

      reportType: data['ReportType'] ?? '',

      companyId: data['CompanyId'] ?? '',
      companyName: data['CompanyName'] ?? '',

      factoryId: data['FactoryId'],
      factoryName: data['FactoryName'],

      month: (data['Month'] as Timestamp).toDate(),

      monthKey: data['MonthKey'] ?? '',

      billNo: data['BillNo'] ?? '',

      totalTrips: data['TotalTrips'] ?? 0,

      totalAmount: (data['TotalAmount'] ?? 0).toDouble(),

      createdAt: (data['CreatedAt'] as Timestamp).toDate(),

      updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),

      createdBy: data['CreatedBy'] ?? '',
    );
  }

  //==========================================================
  // To Json
  //==========================================================

  Map<String, dynamic> toJson() {
    return {
      'ReportType': reportType,

      'CompanyId': companyId,
      'CompanyName': companyName,

      'FactoryId': factoryId,
      'FactoryName': factoryName,

      'Month': Timestamp.fromDate(month),

      'MonthKey': monthKey,

      'BillNo': billNo,

      'TotalTrips': totalTrips,
      'TotalAmount': totalAmount,

      'CreatedAt': Timestamp.fromDate(createdAt),

      'UpdatedAt': Timestamp.fromDate(updatedAt),

      'CreatedBy': createdBy,
    };
  }

  //==========================================================
  // Copy With
  //==========================================================

  ReportModel copyWith({
    String? id,
    String? reportType,

    String? companyId,
    String? companyName,

    String? factoryId,
    String? factoryName,

    DateTime? month,
    String? monthKey,

    String? billNo,

    int? totalTrips,
    double? totalAmount,

    DateTime? createdAt,
    DateTime? updatedAt,

    String? createdBy,
  }) {
    return ReportModel(
      id: id ?? this.id,
      reportType: reportType ?? this.reportType,

      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,

      factoryId: factoryId ?? this.factoryId,
      factoryName: factoryName ?? this.factoryName,

      month: month ?? this.month,
      monthKey: monthKey ?? this.monthKey,

      billNo: billNo ?? this.billNo,

      totalTrips: totalTrips ?? this.totalTrips,
      totalAmount: totalAmount ?? this.totalAmount,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,

      createdBy: createdBy ?? this.createdBy,
    );
  }
}
