class ErrorHandling {
  String? getError(String error) {
    switch (error) {
    // --------------------------
    // Firebase Auth
    // --------------------------
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'The password is invalid.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed.';
      case 'weak-password':
        return 'Your password is too weak.';
      case 'missing-email':
        return 'Please enter your email address.';
      case 'missing-password':
        return 'Please enter your password.';
      case 'invalid-credential':
        return 'Email or Password is incorrect';

    // --------------------------
    // Network
    // --------------------------
      case 'network-request-failed':
        return 'Please check your internet connection and try again.';

    // --------------------------
    // Firestore
    // --------------------------
      case 'already-exists':
        return 'This document already exists.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'data-loss':
        return 'Data loss occurred. Please try again.';
      case 'deadline-exceeded':
        return 'The request took too long. Please try again.';
      case 'failed-precondition':
        return 'Operation failed due to missing or invalid requirements.';
      case 'internal':
        return 'Internal server error. Please try again.';
      case 'invalid-argument':
        return 'Invalid data provided.';
      case 'not-found':
        return 'The requested data was not found.';
      case 'resource-exhausted':
        return 'Quota exceeded. Please wait before trying again.';
      case 'unauthenticated':
        return 'You must be signed in to perform this action.';
      case 'unavailable':
        return 'Service is temporarily unavailable. Please try again later.';
      case 'aborted':
        return 'The operation was aborted due to a conflict.';
      case 'unknown':
        return 'An unknown error occurred.';

    // --------------------------
    // Storage
    // --------------------------
      case 'object-not-found':
        return 'The requested file does not exist.';
      case 'unauthorized':
        return 'You are not authorized to perform this action.';

    // --------------------------
    // Default
    // --------------------------
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
