import 'package:firebase_auth/firebase_auth.dart';
import 'package:vipt/app/core/values/app_strings.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/auth_provider.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/enums/app_enums.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  final AuthProvider _authProvider = AuthProvider();
  final UserProvider _userProvider = UserProvider();

  SignInType _loginType = SignInType.none;
  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogin => currentUser == null ? false : true;
  Future<bool> isHasData() async =>
      await _userProvider.checkIfUserExist(currentUser!.uid);
  SignInType get loginType => _loginType;

  Future<dynamic> signInWithGoogle() async {
    _loginType = SignInType.withGoogle;

    try {
      return await _authProvider.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseExceptionString.operationNotAllow:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.operationNotAllow];
        case FirebaseExceptionString.invalidCode:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidCode];
        case FirebaseExceptionString.invalidVerficationID:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidVerficationID];
        case FirebaseExceptionString.invalidCredential:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidCredential];
        case FirebaseExceptionString.diffCredential:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.diffCredential];
        case FirebaseExceptionString.userDisable:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.userDisable];
        case FirebaseExceptionString.userNotFound:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.userNotFound];
        case FirebaseExceptionString.wrongPassword:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.wrongPassword];
        default:
          break;
      }
    }
  }

  Future<dynamic> signInWithFacebook() async {
    _loginType = SignInType.withFacebook;

    try {
      return await _authProvider.signInWithFacebook();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case FirebaseExceptionString.operationNotAllow:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.operationNotAllow];
        case FirebaseExceptionString.invalidCode:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidCode];
        case FirebaseExceptionString.invalidVerficationID:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidVerficationID];
        case FirebaseExceptionString.invalidCredential:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.invalidCredential];
        case FirebaseExceptionString.diffCredential:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.diffCredential];
        case FirebaseExceptionString.userDisable:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.userDisable];
        case FirebaseExceptionString.userNotFound:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.userNotFound];
        case FirebaseExceptionString.wrongPassword:
          return FirebaseExceptionString
              .exeception[FirebaseExceptionString.wrongPassword];
        default:
          break;
      }
    }
  }

  Future<void> signOut() async {
    if (_loginType == SignInType.withGoogle) {
      await AuthProvider().signOutGoogle();
    } else if (_loginType == SignInType.withFacebook) {
      await AuthProvider().signOutFacebook();
    }
    return await AuthProvider().signOutFirebase();
  }

  Future<bool> checkIfUserExist(String uid) {
    return _userProvider.checkIfUserExist(uid);
  }

  Future<ViPTUser> createViPTUser(ViPTUser user) async {
    return await _userProvider.add(user);
  }
}
