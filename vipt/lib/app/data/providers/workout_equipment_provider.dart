import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutEquipmentProvider
    implements Firestoration<String, WorkoutEquipment> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<WorkoutEquipment> add(WorkoutEquipment obj) {
    throw UnimplementedError();
  }

  @override
  String get collectionPath => AppValue.workoutEquipmentCollectionPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<WorkoutEquipment> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return WorkoutEquipment.fromMap(raw.data() ?? {});
  }

  Future<List<WorkoutEquipment>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<WorkoutEquipment> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutEquipment.fromMap(element.data()));
    }

    return list;
  }

  @override
  Future<WorkoutEquipment> update(String id, WorkoutEquipment obj) {
    throw UnimplementedError();
  }
}
