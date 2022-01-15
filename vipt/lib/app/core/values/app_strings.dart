class FirebaseExceptionString {
  static const Map<String, String> exeception = {
    invalidEmail: '',
    userDisable: '',
    userNotFound: '',
    wrongPassword: '',
    diffCredential: '',
    invalidCredential: '',
    operationNotAllow: '',
    invalidCode: '',
    invalidVerficationID: '',
  };

  static const invalidEmail = 'invalid-email';
  static const userDisable = 'user-disabled';
  static const userNotFound = 'user-not-found';
  static const wrongPassword = 'wrong-password';
  static const diffCredential = 'account-exists-with-different-credential';
  static const invalidCredential = 'invalid-credential';
  static const operationNotAllow = 'operation-not-allowed';
  static const invalidCode = 'invalid-verification-code';
  static const invalidVerficationID = 'invalid-verification-id';
}
