import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import '../models/factory_model.dart';

class FactoryRepository extends GetxController {
  static FactoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get Factories By Company
  Future<List<FactoryModel>> fetchFactoriesByCompany(String companyId) async {
    try {
      final snapshot = await _db
          .collection('Factories')
          .where('CompanyId', isEqualTo: companyId)
          .orderBy('Name')
          .get();

      return snapshot.docs
          .map((doc) => FactoryModel.fromSnapshot(doc))
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

  /// Get Factory By Name
  Future<FactoryModel?> getFactoryByName(
    String companyId,
    String factoryName,
  ) async {
    try {
      final snapshot = await _db
          .collection('Factories')
          .where('CompanyId', isEqualTo: companyId)
          .where('Name', isEqualTo: factoryName)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return FactoryModel.fromSnapshot(snapshot.docs.first);
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

  /// Create Factory
  Future<FactoryModel> createFactory({
    required String companyId,
    required String companyName,
    required String factoryName,
  }) async {
    try {
      final document = _db.collection('Factories').doc();

      final factory = FactoryModel(
        id: document.id,
        companyId: companyId,
        companyName: companyName,
        name: factoryName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await document.set(factory.toJson());

      return factory;
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

  /// Get Or Create Factory
  Future<FactoryModel> getOrCreateFactory({
    required String companyId,
    required String companyName,
    required String factoryName,
  }) async {
    final existingFactory = await getFactoryByName(companyId, factoryName);

    if (existingFactory != null) {
      return existingFactory;
    }

    return await createFactory(
      companyId: companyId,
      companyName: companyName,
      factoryName: factoryName,
    );
  }
}
