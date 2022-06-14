import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutProvider implements Firestoration<String, Workout> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Workout> add(Workout obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  String generateLink(String name, String type, String extenstion) {
    return '${type}_' +
        name.replaceAll(' ', '_').toLowerCase() +
        '.$extenstion';
  }

  @override
  String get collectionPath => AppValue.workoutsPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Workout> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Workout.fromMap(raw.id, raw.data() ?? {});
  }

  @override
  Future<Workout> update(String id, Workout obj) async {
    await _firestore.collection(collectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  @override
  Future<List<Workout>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<Workout> list = [];
    for (var element in raw.docs) {
      list.add(Workout.fromMap(element.id, element.data()));
    }

    return list;
  }
}
