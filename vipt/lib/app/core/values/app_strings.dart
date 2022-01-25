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

class PropertyLink {
  static const userName = 'user/name'; //
  static const userGender = 'user/gender'; //
  static const userDateOfBirth = 'user/dateOfBirth'; //
  static const userHeight = 'user/height/unit'; //
  static const userWeight = 'user/weight/unit'; //
  static const userGoalWeight = 'user/goalWeight'; //
  static const userHobby = 'user/hobby'; //
  static const userLimit = 'user/limit'; //
  static const userSleepTime = 'user/sleepTime'; //
  static const userDiet = 'user/diet'; //
  static const userBadHabit = 'user/badHabit'; //
  static const userProteinSource = 'user/proteinSource'; //
  static const userDailyWater = 'user/dailyWater'; //
  static const userMainGoal = 'user/mainGoal'; //
  static const userBodyType = 'user/bodyType'; //
  static const userExp = 'user/exp'; //
  static const userTypicalDay = 'user/typicalDay'; //
  static const userActiveFrequency = 'user/activeFreq'; //

  static const none = '';
}
