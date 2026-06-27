import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lohaghara_carrier/firebase_options.dart';

import 'app.dart';

void main() async {
  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// GetX local storage
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
