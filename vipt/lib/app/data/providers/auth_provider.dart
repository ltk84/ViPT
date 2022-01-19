import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      return null;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign in with facebook account
  Future<UserCredential?> signInWithFacebook() async {
    signOutFacebook();

    final LoginResult loginResult = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.dialogOnly);

    if (loginResult.accessToken?.token == null) {
      return null;
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOutFirebase() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> signOutFacebook() async {
    return await FacebookAuth.instance.logOut();
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
