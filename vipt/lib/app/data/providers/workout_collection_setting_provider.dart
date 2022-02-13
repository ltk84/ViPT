import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/providers/firestoration.dart';
import 'package:vipt/app/data/services/auth_service.dart';

class WorkoutCollectionSettingProvider
    implements Firestoration<String, CollectionSetting> {
  @override
  Future<CollectionSetting> add(CollectionSetting obj) {
    throw UnimplementedError();
  }

  @override
  String get collectionPath => AppValue.userCollectionPath;

  DocumentReference<Map<String, dynamic>> get _userDoc =>
      FirebaseFirestore.instance
          .collection(AppValue.userCollectionPath)
          .doc(AuthService.instance.currentUser!.uid);

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<CollectionSetting> fetch(String id) {
    throw UnimplementedError();
  }

  @override
  Future<CollectionSetting> update(String id, CollectionSetting obj) async {
    await _userDoc.update({'collectionSetting': obj.toMap()});
    return obj;
  }
}
