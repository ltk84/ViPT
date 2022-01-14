import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogin => currentUser == null ? false : true;
}
