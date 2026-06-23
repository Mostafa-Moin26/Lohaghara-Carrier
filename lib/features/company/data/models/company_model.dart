import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  final String id;

  final String name;
  final String searchName;

  final DateTime createdAt;
  final DateTime updatedAt;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.searchName,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty Model
  static CompanyModel empty() => CompanyModel(
    id: '',
    name: '',
    searchName: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// Copy With
  CompanyModel copyWith({
    String? id,
    String? name,
    String? searchName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      searchName: searchName ?? this.searchName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert Model To Json
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'SearchName': searchName,
      'CreatedAt': Timestamp.fromDate(createdAt),
      'UpdatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// From Snapshot
  factory CompanyModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CompanyModel(
        id: document.id,
        name: data['Name'] ?? '',
        searchName: data['SearchName'] ?? '',
        createdAt: (data['CreatedAt'] as Timestamp).toDate(),
        updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),
      );
    }

    return CompanyModel.empty();
  }
}
