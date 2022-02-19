import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutEquipmentProvider
    implements Firestoration<String, WorkoutEquipment> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<WorkoutEquipment> add(WorkoutEquipment obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  void addFakeData() {
    List<WorkoutEquipment> data = [
      WorkoutEquipment(null, name: 'Bands', imageLink: 'bands'),
      WorkoutEquipment(null, name: 'Foam Roll', imageLink: 'foam-roll'),
      WorkoutEquipment(null, name: 'Barbell', imageLink: 'barbell'),
      WorkoutEquipment(null, name: 'Kettlebells', imageLink: 'kettlebells'),
      WorkoutEquipment(null, name: 'Body Only', imageLink: 'body_only'),
      WorkoutEquipment(null, name: 'Machine', imageLink: 'machine'),
      WorkoutEquipment(null, name: 'Cable', imageLink: 'cable'),
      WorkoutEquipment(null, name: 'Medicine Ball', imageLink: 'medicine_ball'),
      WorkoutEquipment(null, name: 'Dumbbell', imageLink: 'dumbbell'),
      WorkoutEquipment(null, name: 'None', imageLink: 'none'),
      WorkoutEquipment(null, name: 'E-Z Curl Bar', imageLink: 'ez_curl_bar'),
      WorkoutEquipment(null, name: 'Other', imageLink: 'other'),
      WorkoutEquipment(null, name: 'Exercise Ball', imageLink: 'exercise_ball'),
    ];

    for (var item in data) {
      add(item);
    }
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
    return WorkoutEquipment.fromMap(raw.id, raw.data() ?? {});
  }

  Future<List<WorkoutEquipment>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<WorkoutEquipment> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutEquipment.fromMap(element.id, element.data()));
    }

    return list;
  }

  @override
  Future<WorkoutEquipment> update(String id, WorkoutEquipment obj) {
    throw UnimplementedError();
  }
}
