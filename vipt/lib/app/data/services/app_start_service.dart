import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AppStartService {
  AppStartService._privateConstructor();
  static final AppStartService instance = AppStartService._privateConstructor();

  initFirebase() async {
    await Firebase.initializeApp();
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }
}
