import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutCategoryProvider
    implements Firestoration<String, WorkoutCategory> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<WorkoutCategory> add(WorkoutCategory obj) {
    throw UnimplementedError();
  }

  @override
  String get collectionPath => AppValue.workoutCategoryCollectionPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<WorkoutCategory> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return WorkoutCategory.fromMap(raw.data() ?? {});
  }

  Future<List<WorkoutCategory>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<WorkoutCategory> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutCategory.fromMap(element.data()));
    }

    return list;
  }

  @override
  Future<WorkoutCategory> update(String id, WorkoutCategory obj) {
    throw UnimplementedError();
  }
}
