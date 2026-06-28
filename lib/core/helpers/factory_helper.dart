class FactoryHelper {
  FactoryHelper._();

  ///==========================================================
  /// Generate Factory Short Name
  ///
  /// Example:
  /// Meghna Knit Composite Ltd -> Mkcl
  /// Executive Hi-Fashion Ltd -> Ehl
  /// GreenText Composite Ltd -> Gcl
  ///==========================================================
  static String generateShortName(String factoryName) {
    if (factoryName.trim().isEmpty) return '';

    final words = factoryName
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    final buffer = StringBuffer();

    for (int i = 0; i < words.length; i++) {
      final firstChar = words[i][0];

      if (i == 0) {
        buffer.write(firstChar.toUpperCase());
      } else {
        buffer.write(firstChar.toLowerCase());
      }
    }

    return buffer.toString();
  }
}
