/// Exception class for handling various platform-related errors.
class LPlatformException implements Exception {
  /// Error code
  final String code;

  /// Constructor
  LPlatformException(this.code);

  /// Get corresponding human-readable message
  String get message {
    switch (code) {
      // -----------------------------------------------------------
      // Authentication Errors
      // -----------------------------------------------------------

      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';

      case 'invalid-credential':
        return 'The authentication credential provided is invalid.';

      case 'invalid-email':
        return 'The email address format is invalid.';

      case 'invalid-password':
        return 'Incorrect password. Please try again.';

      case 'user-not-found':
        return 'No user found with this email address.';

      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';

      case 'operation-not-allowed':
        return 'This sign-in method is disabled for your Firebase project.';

      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in provider.';

      case 'requires-recent-login':
        return 'Please log in again to perform this sensitive operation.';

      // -----------------------------------------------------------
      // Verification / OTP Errors
      // -----------------------------------------------------------

      case 'invalid-verification-code':
        return 'The verification code is invalid. Please enter a valid code.';

      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request a new code.';

      case 'session-cookie-expired':
        return 'The Firebase session has expired. Please sign in again.';

      case 'session-expired':
        return 'Your verification session has expired. Please request a new OTP again.';

      case 'missing-verification-code':
        return 'Please enter the verification code.';

      case 'missing-verification-id':
        return 'Verification ID is missing.';

      // -----------------------------------------------------------
      // Phone Authentication
      // -----------------------------------------------------------

      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';

      case 'missing-phone-number':
        return 'Phone number is required.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      // -----------------------------------------------------------
      // Network Errors
      // -----------------------------------------------------------

      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';

      case 'timeout':
        return 'The request timed out. Please try again.';

      case 'too-many-requests':
        return 'Too many requests. Please try again later.';

      // -----------------------------------------------------------
      // Platform / Device Errors
      // -----------------------------------------------------------

      case 'invalid-argument':
        return 'An invalid argument was provided to the method.';

      case 'null-error':
        return 'A null value was unexpectedly encountered.';

      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';

      case 'internal-error':
        return 'An internal error occurred. Please try again later.';

      case 'unknown':
        return 'An unknown platform error occurred.';

      case 'channel-error':
        return 'A platform channel communication error occurred.';

      case 'platform-not-supported':
        return 'This platform is not supported for this operation.';

      case 'device-not-supported':
        return 'This device does not support this feature.';

      // -----------------------------------------------------------
      // Permission Errors
      // -----------------------------------------------------------

      case 'permission-denied':
        return 'Permission denied. Please grant the required permissions.';

      case 'camera-access-denied':
        return 'Camera access was denied. Please enable camera permission.';

      case 'location-access-denied':
        return 'Location access was denied. Please enable location permission.';

      case 'microphone-access-denied':
        return 'Microphone access was denied. Please enable microphone permission.';

      case 'storage-access-denied':
        return 'Storage access was denied. Please enable storage permission.';

      case 'notification-permission-denied':
        return 'Notification permission was denied.';

      // -----------------------------------------------------------
      // File / Media Errors
      // -----------------------------------------------------------

      case 'file-not-found':
        return 'The requested file could not be found.';

      case 'file-corrupted':
        return 'The selected file appears to be corrupted.';

      case 'file-too-large':
        return 'The selected file size exceeds the allowed limit.';

      case 'unsupported-file-format':
        return 'This file format is not supported.';

      // -----------------------------------------------------------
      // Storage / Cache Errors
      // -----------------------------------------------------------

      case 'cache-error':
        return 'A cache-related error occurred.';

      case 'storage-full':
        return 'Device storage is full. Please free up some space.';

      // -----------------------------------------------------------
      // API / Server Errors
      // -----------------------------------------------------------

      case 'server-error':
        return 'A server error occurred. Please try again later.';

      case 'api-not-available':
        return 'The requested API service is currently unavailable.';

      case 'service-unavailable':
        return 'The service is temporarily unavailable.';

      // -----------------------------------------------------------
      // Default
      // -----------------------------------------------------------

      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}
