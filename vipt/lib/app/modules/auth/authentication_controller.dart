import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/routes/pages.dart';

class AuthenticationController extends GetxController {
  void handleSignIn(SignInType type) async {
    try {
      final result;
      if (type == SignInType.withGoogle) {
        result = await signInWithGoogle();
      } else {
        result = await signInWithFacebook();
      }

      if (result is String) {
        _handleSignInFail(result);
      } else {
        _handleSignInSucess(result);
      }
    } finally {}
  }

  Future<bool> _checkUserExistence(String uid) async {
    return await AuthService.instance.checkIfUserExist(uid);
  }

  void _handleSignInSucess(UserCredential result) async {
    // bool isExist = await _checkUserExistence(result.user!.uid);
    // if (!isExist) {
    //   Get.offAllNamed(Routes.setupInfo);
    // } else {
    //   Get.offAllNamed(Routes.home);
    // }
    Get.offAllNamed(Routes.setupInfoIntro);
  }

  void _handleSignInFail(String message) {
    // thong bao loi
    // Get.offAllNamed(Routes.error);
    Get.snackbar('Loi vcl', message);
  }

  Future<dynamic> signInWithGoogle() async {
    return await AuthService.instance.signInWithGoogle();
  }

  Future<dynamic> signInWithFacebook() async {
    return await AuthService.instance.signInWithFacebook();
  }
}
