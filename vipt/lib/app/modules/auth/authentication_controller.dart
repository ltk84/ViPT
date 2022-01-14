import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/routes/pages.dart';

class AuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void handleSignIn(SignInType type) async {
    try {
      UserCredential? result;
      if (type == SignInType.withGoogle) {
        result = await signInWithGoogle();
      } else {
        result = await signInWithFacebook();
      }

      if (result != null) {
        _handleSignInSucess();
      } else {
        _handleSignInFail();
      }
    } finally {}
  }

  void _handleSignInSucess() {
    Get.offAllNamed(Routes.home);
  }

  void _handleSignInFail() {
    Get.offAllNamed(Routes.error);
  }

  Future<UserCredential?> signInWithGoogle() async {
    return await AuthService.instance.signInWithGoogle();
  }

  Future<UserCredential?> signInWithFacebook() async {
    return null;
  }
}
