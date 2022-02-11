import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/firestoration.dart';
import 'package:vipt/app/data/services/auth_service.dart';

class WorkoutCollectionProvider
    implements Firestoration<String, WorkoutCollection> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<WorkoutCollection> add(WorkoutCollection obj) async {
    await _userPath.add(obj.toMap()).then((value) => obj.id = value.id);

    return obj;
  }

  CollectionReference<Map<String, dynamic>> get _userPath => _firestore
      .collection(AppValue.userCollectionPath)
      .doc(AuthService.instance.currentUser!.uid)
      .collection(AppValue.userCollectionOfWorkoutCollectionPath);

  @override
  String get collectionPath => AppValue.collectionOfWorkoutCollectionPath;

  @override
  Future<String> delete(String id) async {
    await _userPath.doc(id).delete();
    return id;
  }

  @override
  Future<WorkoutCollection> fetch(String id) async {
    final raw = await _userPath.doc(id).get();
    return WorkoutCollection.fromMap(id, raw.data() ?? {});
  }

  @override
  Future<WorkoutCollection> update(String id, WorkoutCollection obj) async {
    await _userPath.doc(id).update(obj.toMap());

    return obj;
  }

  Future<WorkoutCollection> addDefaultCollection(WorkoutCollection obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  Future<String> deleteDefaultCollection(String id) async {
    await _firestore.collection(collectionPath).doc(id).delete();
    return id;
  }

  Future<WorkoutCollection> addWorkoutToCollection(
      String workoutID, WorkoutCollection wc) async {
    wc.workoutIDs.add(workoutID);
    await update(wc.id ?? "", wc);
    return wc;
  }

  Future<WorkoutCollection> deleteWorkoutFromCollection(
      String workoutID, WorkoutCollection wc) async {
    wc.workoutIDs.remove(workoutID);
    update(wc.id ?? '', wc);
    return wc;
  }

  Future<List<WorkoutCollection>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<WorkoutCollection> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutCollection.fromMap(element.id, element.data()));
    }

    return list;
  }
}
