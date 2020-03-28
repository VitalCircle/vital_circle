class SignInExceptionType {
  /// If the credential data is malformed or has expired.
  static const ERROR_INVALID_CREDENTIAL = 'ERROR_INVALID_CREDENTIAL';

  /// If the user has been disabled (for example, in the Firebase console)
  static const ERROR_USER_DISABLED = 'ERROR_USER_DISABLED';

  /// If there already exists an account with the email address asserted by Google.
  /// Resolve this case by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of them.
  /// This error will only be thrown if the "One account per email address" setting is enabled in the Firebase console (recommended).
  static const ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL = 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL';

  /// Indicates that Google accounts are not enabled.
  static const ERROR_OPERATION_NOT_ALLOWED = 'ERROR_OPERATION_NOT_ALLOWED';

  /// If the action code in the link is malformed, expired, or has already been used.
  /// This can only occur when using [EmailAuthProvider.getCredentialWithLink] to obtain the credential.
  static const ERROR_INVALID_ACTION_CODE = 'ERROR_INVALID_ACTION_CODE';
}
