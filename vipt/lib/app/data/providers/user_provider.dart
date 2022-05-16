import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class UserProvider implements Firestoration<String, ViPTUser> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<ViPTUser> add(ViPTUser obj) async {
    await _firestore.collection(collectionPath).doc(obj.id).set(obj.toMap());
    return obj;
  }

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<ViPTUser> fetch(String id) async {
    final rawData = await _firestore.collection(collectionPath).doc(id).get();

    return ViPTUser.fromMap(rawData.data() ?? {});
  }

  @override
  Future<ViPTUser> update(String id, ViPTUser obj) async {
    await _firestore.collection(collectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  @override
  String get collectionPath => AppValue.usersPath;

  Future<bool> checkIfUserExist(String uid) async {
    var doc = await _firestore.collection(collectionPath).doc(uid).get();
    return doc.exists;
  }

  @override
  Future<List<ViPTUser>> fetchAll() {
    throw UnimplementedError();
  }
}
