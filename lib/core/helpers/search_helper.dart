class SearchHelper {
  SearchHelper._();

  /// Build Search Tokens
  static List<String> buildSearchTokens({
    required String factoryName,
    required String truckNumber,
  }) {
    final Set<String> tokens = {};

    void addPrefixes(String value) {
      final text = value.toLowerCase().trim();

      if (text.isEmpty) return;

      // Whole value prefixes
      for (int i = 1; i <= text.length; i++) {
        tokens.add(text.substring(0, i));
      }

      // Word prefixes
      final words = text.split(RegExp(r'\s+'));

      for (final word in words) {
        if (word.isEmpty) continue;

        for (int i = 1; i <= word.length; i++) {
          tokens.add(word.substring(0, i));
        }
      }

      // Numeric prefixes (Truck Number)
      final numbers = RegExp(
        r'\d+',
      ).allMatches(text).map((e) => e.group(0)!).toList();

      for (final number in numbers) {
        for (int i = 1; i <= number.length; i++) {
          tokens.add(number.substring(0, i));
        }
      }
    }

    addPrefixes(factoryName);

    addPrefixes(truckNumber);

    return tokens.toList()..sort();
  }
}
