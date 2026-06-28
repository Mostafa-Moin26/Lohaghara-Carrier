import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

/// Loads and caches PDF fonts.
/// Call [PdfFonts.load()] once before generating any PDF.
class PdfFonts {
  PdfFonts._();

  static late final pw.Font regular;
  static late final pw.Font bold;

  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;

    regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/poppins.regular.ttf'),
    );

    bold = pw.Font.ttf(await rootBundle.load('assets/fonts/poppins.bold.ttf'));

    _loaded = true;
  }
}
