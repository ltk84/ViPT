import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutProvider implements Firestoration<String, Workout> {
  @override
  Future<Workout> add(Workout obj) {
    throw UnimplementedError();
  }

  @override
  String get collectionPath => AppValue.workoutCollectionPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Workout> fetch(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Workout> update(String id, Workout obj) {
    throw UnimplementedError();
  }
}
