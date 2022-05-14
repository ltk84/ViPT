import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class WorkoutCollectionCategoryProvider
    implements Firestoration<String, Category> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Category> add(Category obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  void addFakeData() async {
    final List<Category> data = [
      Category(null, name: 'Strength', asset: 'asset', parentCategoryID: null),
      Category(null,
          name: 'HIIT, Cardio', asset: 'asset', parentCategoryID: null),
      Category(null,
          name: 'Yoga, Stretching', asset: 'asset', parentCategoryID: null),
      Category(null,
          name: 'Warmup, Recovery', asset: 'asset', parentCategoryID: null),
    ];

    for (var item in data) {
      await add(item);
    }
  }

  @override
  String get collectionPath => AppValue.workoutCollectionCategoriesPath;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Category> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Category.fromMap(raw.id, raw.data() ?? {});
  }

  @override
  Future<List<Category>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<Category> list = [];
    for (var element in raw.docs) {
      list.add(Category.fromMap(element.id, element.data()));
    }

    return list;
  }

  @override
  Future<Category> update(String id, Category obj) {
    throw UnimplementedError();
  }
}
