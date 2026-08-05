import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/exceptions/firebase_exceptions.dart';
import '../../../../core/exceptions/format_exceptions.dart';
import '../../../../core/exceptions/platform_exceptions.dart';
import '../models/report_model.dart';

class ReportRepository extends GetxController {
  static ReportRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //==========================================================
  // Collection
  //==========================================================

  CollectionReference<Map<String, dynamic>> get _reports =>
      _db.collection('Reports');

  //==========================================================
  // Save Report (Create / Update)
  //==========================================================

  Future<void> saveReport(ReportModel report) async {
    try {
      final document = _reports.doc(report.id);

      final snapshot = await document.get();

      ///------------------------------------------------------
      /// Create
      ///------------------------------------------------------

      if (!snapshot.exists) {
        final newReport = report.copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await document.set(newReport.toJson());

        return;
      }

      ///------------------------------------------------------
      /// Update
      ///------------------------------------------------------

      final oldReport = ReportModel.fromSnapshot(snapshot);

      final updatedReport = report.copyWith(
        createdAt: oldReport.createdAt,
        updatedAt: DateTime.now(),
      );

      await document.set(updatedReport.toJson());
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //==========================================================
  // Fetch All Reports
  //==========================================================

  Future<List<ReportModel>> fetchReports() async {
    try {
      final snapshot = await _reports
          .orderBy('UpdatedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => ReportModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  //==========================================================
  // Delete Report
  //==========================================================

  Future<void> deleteReport(String reportId) async {
    try {
      await _reports.doc(reportId).delete();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
