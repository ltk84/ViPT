import 'package:firebase_core/firebase_core.dart';

class AppStartService {
  AppStartService._privateConstructor();
  static final AppStartService instance = AppStartService._privateConstructor();

  initService() async {
    await Firebase.initializeApp();
  }
}
