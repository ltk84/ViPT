import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/routes/pages.dart';

class AuthenticationController extends GetxController {
  void handleSignIn(SignInType type) async {
    try {
      final dynamic result;
      if (type == SignInType.withGoogle) {
        result = await _signInWithGoogle();
      } else {
        result = await _signInWithFacebook();
      }

      if (result != null) {
        if (result is! String) {
          _handleSignInSucess(result);
        } else {
          _handleSignInFail(result);
        }
      }
    } finally {}
  }

  Future<bool> _checkUserExistence(String uid) async {
    return await AuthService.instance.checkIfUserExist(uid);
  }

  void _handleSignInSucess(UserCredential result) async {
    bool isExist = await _checkUserExistence(result.user!.uid);
    if (!isExist) {
      Get.offAllNamed(Routes.setupInfoIntro);
    } else {
      await DataService.instance.loadUserData();
      Get.offAllNamed(Routes.home);
    }
  }

  void _handleSignInFail(String message) {
    // thong bao loi
    // Get.offAllNamed(Routes.error);
    Get.snackbar('Loi vcl', message);
  }

  Future<dynamic> _signInWithGoogle() async {
    return await AuthService.instance.signInWithGoogle();
  }

  Future<dynamic> _signInWithFacebook() async {
    return await AuthService.instance.signInWithFacebook();
  }
}
