/// Custom exception class to handle various format-related errors.
class NubifyFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const NubifyFormatException([
    this.message =
        'An unexpected format error occurred. Please check your input.',
  ]);

  /// Create a format exception from a specific error message.
  factory NubifyFormatException.fromMessage(String message) {
    return NubifyFormatException(message);
  }

  /// Get the corresponding formatted error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory NubifyFormatException.fromCode(String code) {
    switch (code) {
      // -----------------------------------------------------------
      // Email / Authentication Formats
      // -----------------------------------------------------------

      case 'invalid-email-format':
        return const NubifyFormatException(
          'The email address format is invalid. Please enter a valid email.',
        );

      case 'invalid-password-format':
        return const NubifyFormatException(
          'Password format is invalid. Please use a stronger password.',
        );

      case 'invalid-phone-number-format':
        return const NubifyFormatException(
          'The phone number format is invalid. Please enter a valid number.',
        );

      case 'invalid-verification-code-format':
        return const NubifyFormatException(
          'The verification code format is invalid.',
        );

      // -----------------------------------------------------------
      // Date / Time Formats
      // -----------------------------------------------------------

      case 'invalid-date-format':
        return const NubifyFormatException(
          'The date format is invalid. Please enter a valid date.',
        );

      case 'invalid-time-format':
        return const NubifyFormatException(
          'The time format is invalid.',
        );

      case 'invalid-datetime-format':
        return const NubifyFormatException(
          'The date and time format is invalid.',
        );

      // -----------------------------------------------------------
      // URL / Web Formats
      // -----------------------------------------------------------

      case 'invalid-url-format':
        return const NubifyFormatException(
          'The URL format is invalid. Please enter a valid URL.',
        );

      case 'invalid-domain-format':
        return const NubifyFormatException(
          'The domain format is invalid.',
        );

      // -----------------------------------------------------------
      // Payment / Card Formats
      // -----------------------------------------------------------

      case 'invalid-credit-card-format':
        return const NubifyFormatException(
          'The credit card format is invalid. Please enter a valid card number.',
        );

      case 'invalid-cvv-format':
        return const NubifyFormatException(
          'The CVV format is invalid.',
        );

      case 'invalid-expiry-date-format':
        return const NubifyFormatException(
          'The expiry date format is invalid.',
        );

      // -----------------------------------------------------------
      // Number Formats
      // -----------------------------------------------------------

      case 'invalid-numeric-format':
        return const NubifyFormatException(
          'The input should be a valid numeric value.',
        );

      case 'invalid-double-format':
        return const NubifyFormatException(
          'The decimal number format is invalid.',
        );

      case 'invalid-integer-format':
        return const NubifyFormatException(
          'The integer format is invalid.',
        );

      // -----------------------------------------------------------
      // JSON / Data Parsing
      // -----------------------------------------------------------

      case 'invalid-json-format':
        return const NubifyFormatException(
          'The JSON data format is invalid.',
        );

      case 'invalid-map-format':
        return const NubifyFormatException(
          'The map data format is invalid.',
        );

      case 'invalid-list-format':
        return const NubifyFormatException(
          'The list data format is invalid.',
        );

      // -----------------------------------------------------------
      // File / Media Formats
      // -----------------------------------------------------------

      case 'invalid-image-format':
        return const NubifyFormatException(
          'The selected image format is not supported.',
        );

      case 'invalid-file-format':
        return const NubifyFormatException(
          'The file format is invalid or unsupported.',
        );

      case 'invalid-video-format':
        return const NubifyFormatException(
          'The video format is invalid or unsupported.',
        );

      // -----------------------------------------------------------
      // User Input Formats
      // -----------------------------------------------------------

      case 'empty-field':
        return const NubifyFormatException(
          'Required field cannot be empty.',
        );

      case 'invalid-name-format':
        return const NubifyFormatException(
          'The name format is invalid.',
        );

      case 'invalid-username-format':
        return const NubifyFormatException(
          'The username format is invalid.',
        );

      case 'invalid-address-format':
        return const NubifyFormatException(
          'The address format is invalid.',
        );

      case 'invalid-zip-code-format':
        return const NubifyFormatException(
          'The ZIP/postal code format is invalid.',
        );

      // -----------------------------------------------------------
      // Firebase / Backend Data
      // -----------------------------------------------------------

      case 'invalid-document-format':
        return const NubifyFormatException(
          'The document data format is invalid.',
        );

      case 'invalid-response-format':
        return const NubifyFormatException(
          'The server response format is invalid.',
        );

      case 'invalid-api-format':
        return const NubifyFormatException(
          'The API response format is invalid.',
        );

      // -----------------------------------------------------------
      // Default
      // -----------------------------------------------------------

      default:
        return const NubifyFormatException(
          'An unexpected format error occurred. Please check your input.',
        );
    }
  }
}
