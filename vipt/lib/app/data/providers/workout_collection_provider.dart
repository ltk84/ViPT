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
    await _userCollectionPath
        .add(obj.toMap())
        .then((value) => obj.id = value.id);

    return obj;
  }

  void addFakeData() {
    final data = [
      WorkoutCollection(
        null,
        title: 'Fight till die',
        description: 'Let fight till we die',
        workoutIDs: ['QCVbVHUwqI60DBrEcZIs'],
        categoryIDs: ['VdOqUgsCGARIYyu1zCe3'],
      ),
      WorkoutCollection(
        null,
        title: 'Stretch till die',
        description: 'Let stretch till we die',
        workoutIDs: ['oLrjD5ZIqtIH8XDBJTLK'],
        categoryIDs: ['aHc37ervZP5whfU2pWc3'],
      ),
      WorkoutCollection(
        null,
        title: 'Cardio till die',
        description: 'Let cardio till we die',
        workoutIDs: ['WPOwO0boeOMyBbCdVuPr'],
        categoryIDs: ['pn8jgNN2MM6bwzckhaAH'],
      ),
    ];

    for (var item in data) {
      addDefaultCollection(item);
    }
  }

  void addUserCollectionFakeData() {
    final data = [
      WorkoutCollection(
        null,
        title: 'Tinh yeu la tro choi',
        description: 'Ai choi hay nguoi do thang',
        workoutIDs: ['QCVbVHUwqI60DBrEcZIs'],
        categoryIDs: [],
      ),
      WorkoutCollection(
        null,
        title: 'Yeu em dai kho',
        description: 'Lou Hoang',
        workoutIDs: ['oLrjD5ZIqtIH8XDBJTLK'],
        categoryIDs: [],
      ),
      WorkoutCollection(
        null,
        title: 'Day tui cach iu',
        description: 'TLinh',
        workoutIDs: ['WPOwO0boeOMyBbCdVuPr'],
        categoryIDs: [],
      ),
    ];

    for (var item in data) {
      add(item);
    }
  }

  CollectionReference<Map<String, dynamic>> get _userCollectionPath =>
      _firestore
          .collection(AppValue.userCollectionsPath)
          .doc(AuthService.instance.currentUser!.uid)
          .collection(AppValue.collectionOfSingleUserPath);

  @override
  String get collectionPath => AppValue.workoutCollectionsPath;

  @override
  Future<String> delete(String id) async {
    await _userCollectionPath.doc(id).delete();
    return id;
  }

  @override
  Future<WorkoutCollection> fetch(String id) async {
    final raw = await _userCollectionPath.doc(id).get();
    return WorkoutCollection.fromMap(id, raw.data() ?? {});
  }

  @override
  Future<WorkoutCollection> update(String id, WorkoutCollection obj) async {
    await _userCollectionPath.doc(id).update(obj.toMap());

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

  Future<List<WorkoutCollection>> fetchAllDefaultCollection() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<WorkoutCollection> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutCollection.fromMap(element.id, element.data()));
    }

    return list;
  }

  Future<List<WorkoutCollection>> fetchAllUserCollection() async {
    QuerySnapshot<Map<String, dynamic>> raw = await _userCollectionPath.get();

    List<WorkoutCollection> list = [];
    for (var element in raw.docs) {
      list.add(WorkoutCollection.fromMap(element.id, element.data()));
    }

    return list;
  }
}
