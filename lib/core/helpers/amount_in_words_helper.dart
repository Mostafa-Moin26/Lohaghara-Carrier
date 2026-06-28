class AmountInWordsHelper {
  AmountInWordsHelper._();

  static const List<String> _units = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];

  static const List<String> _tens = [
    '',
    '',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety',
  ];

  static String convert(num amount) {
    int value = amount.round();

    if (value == 0) {
      return 'Zero Taka Only.';
    }

    return '${_convertNumber(value).trim()} Taka Only.';
  }

  static String _convertNumber(int number) {
    if (number < 20) {
      return _units[number];
    }

    if (number < 100) {
      return '${_tens[number ~/ 10]} ${_convertNumber(number % 10)}';
    }

    if (number < 1000) {
      return '${_convertNumber(number ~/ 100)} Hundred ${_convertNumber(number % 100)}';
    }

    if (number < 100000) {
      return '${_convertNumber(number ~/ 1000)} Thousand ${_convertNumber(number % 1000)}';
    }

    if (number < 10000000) {
      return '${_convertNumber(number ~/ 100000)} Lac ${_convertNumber(number % 100000)}';
    }

    if (number < 1000000000) {
      return '${_convertNumber(number ~/ 10000000)} Crore ${_convertNumber(number % 10000000)}';
    }

    return number.toString();
  }
}
