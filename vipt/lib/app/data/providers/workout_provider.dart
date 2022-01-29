import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutProvider implements Firestoration<String, Workout> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Workout> add(Workout obj) async {
    await _firestore.collection(collectionPath).doc(obj.id).set(obj.toMap());
    return obj;
  }

  @override
  String get collectionPath => AppValue.workoutCollectionPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Workout> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Workout.fromMap(raw.data() ?? {});
  }

  @override
  Future<Workout> update(String id, Workout obj) {
    throw UnimplementedError();
  }
}
