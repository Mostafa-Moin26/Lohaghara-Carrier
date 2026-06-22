import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import '../models/company_model.dart';

class CompanyRepository extends GetxController {
  static CompanyRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get All Companies
  Future<List<CompanyModel>> fetchAllCompanies() async {
    try {
      final snapshot = await _db.collection('Companies').orderBy('Name').get();

      return snapshot.docs
          .map((doc) => CompanyModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Company By Name
  Future<CompanyModel?> getCompanyByName(String companyName) async {
    try {
      final snapshot = await _db
          .collection('Companies')
          .where('Name', isEqualTo: companyName)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return CompanyModel.fromSnapshot(snapshot.docs.first);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Create Company
  Future<CompanyModel> createCompany(String companyName) async {
    try {
      final document = _db.collection('Companies').doc();

      final company = CompanyModel(
        id: document.id,
        name: companyName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await document.set(company.toJson());

      return company;
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Or Create Company
  Future<CompanyModel> getOrCreateCompany(String companyName) async {
    final existingCompany = await getCompanyByName(companyName);

    if (existingCompany != null) {
      return existingCompany;
    }

    return await createCompany(companyName);
  }
}
