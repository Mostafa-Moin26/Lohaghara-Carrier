import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/firebase_options.dart';

import 'app.dart';

void main() async {
  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
