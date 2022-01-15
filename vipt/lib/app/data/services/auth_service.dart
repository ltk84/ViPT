import 'package:firebase_auth/firebase_auth.dart';
import 'package:vipt/app/data/providers/auth_provider.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogin => currentUser == null ? false : true;

  Future<UserCredential?> signInWithGoogle() async {
    return await AuthProvider().signInWithGoogle();
  }

  Future<UserCredential?> signInWithFacebook() async {}

  Future<void> signOut() async {
    return await AuthProvider().signOut();
  }
}
