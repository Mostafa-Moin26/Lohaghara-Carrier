/// Custom exception class to handle various Firebase authentication-related errors.
class LFirebaseAuthException implements Exception {
  /// The Firebase error code.
  final String code;

  /// Constructor

  LFirebaseAuthException(this.code);

  /// Get readable error message
  String get message {
    switch (code) {
      // -----------------------------------------------------------
      // Sign Up / Login Errors
      // -----------------------------------------------------------

      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';

      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';

      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';

      case 'wrong-password':
        return 'Incorrect password. Please try again.';

      case 'user-not-found':
        return 'No user found with this email address.';

      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';

      case 'too-many-requests':
        return 'Too many requests detected. Please try again later.';

      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      case 'internal-error':
        return 'An internal authentication error occurred. Please try again.';

      case 'invalid-credential':
        return 'The provided authentication credential is invalid.';

      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';

      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';

      case 'credential-already-in-use':
        return 'This credential is already associated with another account.';

      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter the correct code.';

      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';

      case 'session-expired':
        return 'The verification session has expired. Please request a new code.';

      case 'missing-verification-code':
        return 'Verification code is missing. Please enter the code.';

      case 'missing-verification-id':
        return 'Verification ID is missing.';

      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication.';

      case 'keychain-error':
        return 'A secure storage error occurred. Please try again.';

      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';

      case 'provider-already-linked':
        return 'This account is already linked with another provider.';

      case 'no-such-provider':
        return 'This sign-in provider is not associated with this account.';

      case 'invalid-user-token':
        return 'User token is invalid. Please sign in again.';

      case 'user-token-expired':
        return 'User session has expired. Please sign in again.';

      case 'null-user':
        return 'No authenticated user found.';

      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';

      case 'invalid-action-code':
        return 'The action code is invalid. Please request a new one.';

      case 'missing-action-code':
        return 'Action code is missing.';

      case 'captcha-check-failed':
        return 'reCAPTCHA verification failed. Please try again.';

      case 'web-storage-unsupported':
        return 'Web storage is not supported or disabled in this browser.';

      case 'popup-blocked':
        return 'Popup was blocked by the browser. Please allow popups and try again.';

      case 'popup-closed-by-user':
        return 'Popup was closed before completing sign in.';

      case 'unauthorized-domain':
        return 'This domain is not authorized for Firebase Authentication.';

      // -----------------------------------------------------------
      // Phone Authentication Errors
      // -----------------------------------------------------------

      case 'invalid-phone-number':
        return 'The phone number entered is invalid.';

      case 'missing-phone-number':
        return 'Please enter a phone number.';

      case 'sms-code-expired':
        return 'SMS code has expired. Please request a new code.';

      // -----------------------------------------------------------
      // Multi-factor Authentication Errors
      // -----------------------------------------------------------

      case 'second-factor-already-in-use':
        return 'The second factor is already enrolled on this account.';

      case 'maximum-second-factor-count-exceeded':
        return 'Maximum number of second factors exceeded.';

      case 'unsupported-first-factor':
        return 'The first factor is not supported.';

      case 'unverified-email':
        return 'Please verify your email before continuing.';

      // -----------------------------------------------------------
      // Default
      // -----------------------------------------------------------

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
