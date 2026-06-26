import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/helpers/search_helper.dart';

class RecordMigrationService {
  RecordMigrationService._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// One Time Migration
  static Future<void> migrateSearchTokens() async {
    final snapshot = await _db.collection('Records').get();

    final batch = _db.batch();

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final factoryName = data['FactoryName'] ?? '';

      final truckNumber = data['TruckNumber'] ?? '';

      final tokens = SearchHelper.buildSearchTokens(
        factoryName: factoryName,
        truckNumber: truckNumber,
      );

      batch.update(doc.reference, {'SearchTokens': tokens});
    }

    await batch.commit();
  }
}
