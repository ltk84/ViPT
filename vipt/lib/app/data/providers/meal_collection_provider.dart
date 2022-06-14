import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class MealCollectionProvider implements Firestoration<String, MealCollection> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<MealCollection> add(MealCollection obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  @override
  String get collectionPath => AppValue.mealCollections;

  @override
  Future<String> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<MealCollection> fetch(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<MealCollection>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<MealCollection> list = [];
    for (var element in raw.docs) {
      list.add(MealCollection.fromMap(element.id, element.data()));
    }

    return list;
  }

  @override
  Future<MealCollection> update(String id, MealCollection obj) {
    throw UnimplementedError();
  }
}
