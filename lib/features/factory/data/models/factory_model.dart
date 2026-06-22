import 'package:cloud_firestore/cloud_firestore.dart';

class FactoryModel {
  final String id;

  final String companyId;
  final String companyName;

  final String name;

  final DateTime createdAt;
  final DateTime updatedAt;

  const FactoryModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty Model
  static FactoryModel empty() => FactoryModel(
    id: '',
    companyId: '',
    companyName: '',
    name: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// Copy With
  FactoryModel copyWith({
    String? id,
    String? companyId,
    String? companyName,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FactoryModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert Model To Json
  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'CompanyName': companyName,

      'Name': name,

      'CreatedAt': Timestamp.fromDate(createdAt),
      'UpdatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// From Snapshot
  factory FactoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return FactoryModel(
        id: document.id,

        companyId: data['CompanyId'] ?? '',
        companyName: data['CompanyName'] ?? '',

        name: data['Name'] ?? '',

        createdAt: (data['CreatedAt'] as Timestamp).toDate(),
        updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),
      );
    }

    return FactoryModel.empty();
  }
}
