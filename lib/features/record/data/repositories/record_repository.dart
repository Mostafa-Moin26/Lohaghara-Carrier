import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';

class RecordRepository extends GetxController {
  static RecordRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create Record
  Future<RecordModel> addRecord(RecordModel record) async {
    try {
      final document = _db.collection('Records').doc();

      final recordWithMetadata = record.copyWith(
        id: document.id,
        createdBy: AuthenticationRepository.instance.authUser!.uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await document.set(recordWithMetadata.toJson());

      return recordWithMetadata;
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get All Records
  Future<List<RecordModel>> fetchAllRecords() async {
    try {
      final snapshot = await _db
          .collection('Records')
          .orderBy('Date', descending: true)
          .get();

      return snapshot.docs
          .map((document) => RecordModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update Record
  Future<void> updateRecord(RecordModel record) async {
    try {
      await _db
          .collection('Records')
          .doc(record.id)
          .update(record.copyWith(updatedAt: DateTime.now()).toJson());
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Delete Record
  Future<void> deleteRecord(String recordId) async {
    try {
      await _db.collection('Records').doc(recordId).delete();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Single Record
  Future<RecordModel> fetchRecordById(String recordId) async {
    try {
      final document = await _db.collection('Records').doc(recordId).get();

      if (document.exists) {
        return RecordModel.fromSnapshot(document);
      }

      return RecordModel.empty();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
