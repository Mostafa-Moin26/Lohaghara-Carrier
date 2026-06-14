/// Custom exception class to handle various format-related errors.
class LFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const LFormatException([
    this.message =
        'An unexpected format error occurred. Please check your input.',
  ]);

  /// Create a format exception from a specific error message.
  factory LFormatException.fromMessage(String message) {
    return LFormatException(message);
  }

  /// Get the corresponding formatted error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory LFormatException.fromCode(String code) {
    switch (code) {
      // -----------------------------------------------------------
      // Email / Authentication Formats
      // -----------------------------------------------------------

      case 'invalid-email-format':
        return const LFormatException(
          'The email address format is invalid. Please enter a valid email.',
        );

      case 'invalid-password-format':
        return const LFormatException(
          'Password format is invalid. Please use a stronger password.',
        );

      case 'invalid-phone-number-format':
        return const LFormatException(
          'The phone number format is invalid. Please enter a valid number.',
        );

      case 'invalid-verification-code-format':
        return const LFormatException(
          'The verification code format is invalid.',
        );

      // -----------------------------------------------------------
      // Date / Time Formats
      // -----------------------------------------------------------

      case 'invalid-date-format':
        return const LFormatException(
          'The date format is invalid. Please enter a valid date.',
        );

      case 'invalid-time-format':
        return const LFormatException('The time format is invalid.');

      case 'invalid-datetime-format':
        return const LFormatException('The date and time format is invalid.');

      // -----------------------------------------------------------
      // URL / Web Formats
      // -----------------------------------------------------------

      case 'invalid-url-format':
        return const LFormatException(
          'The URL format is invalid. Please enter a valid URL.',
        );

      case 'invalid-domain-format':
        return const LFormatException('The domain format is invalid.');

      // -----------------------------------------------------------
      // Payment / Card Formats
      // -----------------------------------------------------------

      case 'invalid-credit-card-format':
        return const LFormatException(
          'The credit card format is invalid. Please enter a valid card number.',
        );

      case 'invalid-cvv-format':
        return const LFormatException('The CVV format is invalid.');

      case 'invalid-expiry-date-format':
        return const LFormatException('The expiry date format is invalid.');

      // -----------------------------------------------------------
      // Number Formats
      // -----------------------------------------------------------

      case 'invalid-numeric-format':
        return const LFormatException(
          'The input should be a valid numeric value.',
        );

      case 'invalid-double-format':
        return const LFormatException('The decimal number format is invalid.');

      case 'invalid-integer-format':
        return const LFormatException('The integer format is invalid.');

      // -----------------------------------------------------------
      // JSON / Data Parsing
      // -----------------------------------------------------------

      case 'invalid-json-format':
        return const LFormatException('The JSON data format is invalid.');

      case 'invalid-map-format':
        return const LFormatException('The map data format is invalid.');

      case 'invalid-list-format':
        return const LFormatException('The list data format is invalid.');

      // -----------------------------------------------------------
      // File / Media Formats
      // -----------------------------------------------------------

      case 'invalid-image-format':
        return const LFormatException(
          'The selected image format is not supported.',
        );

      case 'invalid-file-format':
        return const LFormatException(
          'The file format is invalid or unsupported.',
        );

      case 'invalid-video-format':
        return const LFormatException(
          'The video format is invalid or unsupported.',
        );

      // -----------------------------------------------------------
      // User Input Formats
      // -----------------------------------------------------------

      case 'empty-field':
        return const LFormatException('Required field cannot be empty.');

      case 'invalid-name-format':
        return const LFormatException('The name format is invalid.');

      case 'invalid-username-format':
        return const LFormatException('The username format is invalid.');

      case 'invalid-address-format':
        return const LFormatException('The address format is invalid.');

      case 'invalid-zip-code-format':
        return const LFormatException('The ZIP/postal code format is invalid.');

      // -----------------------------------------------------------
      // Firebase / Backend Data
      // -----------------------------------------------------------

      case 'invalid-document-format':
        return const LFormatException('The document data format is invalid.');

      case 'invalid-response-format':
        return const LFormatException('The server response format is invalid.');

      case 'invalid-api-format':
        return const LFormatException('The API response format is invalid.');

      // -----------------------------------------------------------
      // Default
      // -----------------------------------------------------------

      default:
        return const LFormatException(
          'An unexpected format error occurred. Please check your input.',
        );
    }
  }
}
