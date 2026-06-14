/// Custom exception class to handle Firebase-related errors.
class NubifyFirebaseException implements Exception {
  /// The associated Firebase error code.
  final String code;

  /// Constructor
  NubifyFirebaseException(this.code);

  /// Get corresponding human-readable message.
  String get message {
    switch (code) {
      // -----------------------------------------------------------
      // General Firebase Errors
      // -----------------------------------------------------------

      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';

      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';

      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';

      case 'user-disabled':
        return 'The user account has been disabled.';

      case 'user-not-found':
        return 'No user found for the given email or UID.';

      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';

      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';

      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';

      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';

      case 'provider-already-linked':
        return 'The account is already linked with another provider.';

      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';

      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';

      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';

      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';

      case 'captcha-check-failed':
        return 'reCAPTCHA verification failed. Please try again.';

      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication.';

      case 'keychain-error':
        return 'A keychain error occurred. Please restart the app and try again.';

      case 'internal-error':
        return 'An internal Firebase error occurred. Please try again later.';

      case 'invalid-app-credential':
        return 'The app credential is invalid.';

      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';

      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';

      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';

      case 'credential-already-in-use':
        return 'This credential is already associated with another user account.';

      case 'timeout':
        return 'The operation has timed out. Please try again.';

      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many requests. Please wait and try again later.';

      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';

      case 'missing-phone-number':
        return 'Phone number is missing. Please enter a valid phone number.';

      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';

      case 'session-expired':
        return 'The SMS code has expired. Please request a new verification code.';

      case 'missing-verification-code':
        return 'The verification code is missing. Please enter the code.';

      case 'missing-verification-id':
        return 'The verification ID is missing.';

      case 'popup-closed-by-user':
        return 'The popup has been closed before completing the sign in process.';

      case 'popup-blocked':
        return 'The popup has been blocked by the browser. Please enable popups and try again.';

      case 'unauthorized-domain':
        return 'This domain is not authorized for Firebase operations.';

      case 'web-storage-unsupported':
        return 'Web storage is unsupported or disabled in this browser.';

      case 'invalid-api-key':
        return 'The Firebase API key is invalid.';

      case 'app-deleted':
        return 'This Firebase app instance has been deleted.';

      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';

      case 'invalid-action-code':
        return 'The action code is invalid.';

      case 'missing-action-code':
        return 'The action code is missing.';

      case 'invalid-continue-uri':
        return 'The continue URL provided is invalid.';

      case 'missing-continue-uri':
        return 'A continue URL must be provided in the request.';

      case 'unauthorized-continue-uri':
        return 'The domain of the continue URL is not authorized.';

      // -----------------------------------------------------------
      // Firestore Errors
      // -----------------------------------------------------------

      case 'permission-denied':
        return 'You do not have permission to perform this operation.';

      case 'not-found':
        return 'The requested document or resource was not found.';

      case 'already-exists':
        return 'The document already exists.';

      case 'resource-exhausted':
        return 'Firebase resource limit has been exceeded.';

      case 'failed-precondition':
        return 'Operation failed due to system state.';

      case 'aborted':
        return 'The operation was aborted. Please retry.';

      case 'out-of-range':
        return 'Operation was attempted past the valid range.';

      case 'unimplemented':
        return 'This operation is not implemented or supported.';

      case 'data-loss':
        return 'Unrecoverable data loss or corruption occurred.';

      case 'cancelled':
        return 'The operation was cancelled.';

      // -----------------------------------------------------------
      // Firebase Storage Errors
      // -----------------------------------------------------------

      case 'object-not-found':
        return 'No object exists at the specified reference.';

      case 'bucket-not-found':
        return 'No Firebase Storage bucket is configured.';

      case 'project-not-found':
        return 'No Firebase project was found.';

      case 'download-size-exceeded':
        return 'The download size exceeds the allowed limit.';

      case 'retry-limit-exceeded':
        return 'Maximum retry time exceeded. Please try again later.';

      case 'invalid-checksum':
        return 'File checksum does not match. The file may be corrupted.';

      case 'cannot-slice-blob':
        return 'The file cannot be processed properly.';

      // -----------------------------------------------------------
      // Default
      // -----------------------------------------------------------

      default:
        return 'Something went wrong with Firebase. Please try again.';
    }
  }
}
