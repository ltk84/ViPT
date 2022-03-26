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

  // void addFakeData() {
  //   final data = [
  //     WorkoutCollection(
  //       null,
  //       title: 'HIIT',
  //       description:
  //           'High-intensity cardio exercises to boost your metabolism as quickly as possible.',
  //       generatorIDs: ['Gwif2wxSJ4MCGh9xT9bs'],
  //       categoryIDs: ['5gseIyVRVNbRs9OKG8Pz'],
  //     ),
  //     WorkoutCollection(
  //       null,
  //       title: 'Full Body Stretching',
  //       description:
  //           'Classic stretches to increase flexibility and release all your muscles. Great cool-down after a workout.',
  //       generatorIDs: ['Rxb89cZTkXtSLvghJeei'],
  //       categoryIDs: ['34mBd6uHde3VQQMYXUYD'],
  //     ),
  //     // WorkoutCollection(
  //     //   null,
  //     //   title: 'Complex Upper Body',
  //     //   description:
  //     //       'A fun and effective workout that will challenge all your upper body.',
  //     //   generatorIDs: [],
  //     //   categoryIDs: ['x52QcIaOEBTW5J8J7S1U'],
  //     // ),
  //   ];

  //   for (var item in data) {
  //     addDefaultCollection(item);
  //   }
  // }

  // void addUserCollectionFakeData() {
  //   final data = [
  //     WorkoutCollection(
  //       null,
  //       title: 'Insane Six Pack',
  //       description:
  //           'Ab workout that will get you a shredded six-pack in no time.',
  //       generatorIDs: [],
  //       categoryIDs: ['jOLYMcvtft5eUGyv2ciW'],
  //     ),
  //     WorkoutCollection(
  //       null,
  //       title: 'Complex Lower Body',
  //       description:
  //           'Full lower body workout. This is the leg day you should never skip.',
  //       generatorIDs: [],
  //       categoryIDs: ['4JX1H4ZFDkb85zQkA6df'],
  //     ),
  //     WorkoutCollection(
  //       null,
  //       title: 'Complex Upper Body',
  //       description:
  //           'A fun and effective workout that will challenge all your upper body.',
  //       generatorIDs: [],
  //       categoryIDs: ['TOcjJylRaR8D7tJHbz8z'],
  //     ),
  //   ];

  //   for (var item in data) {
  //     add(item);
  //   }
  // }

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
    wc.generatorIDs.add(workoutID);
    await update(wc.id ?? "", wc);
    return wc;
  }

  Future<WorkoutCollection> deleteWorkoutFromCollection(
      String workoutID, WorkoutCollection wc) async {
    wc.generatorIDs.remove(workoutID);
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

  @override
  Future<List<WorkoutCollection>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }
}
