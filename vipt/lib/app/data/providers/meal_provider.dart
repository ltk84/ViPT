import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/fake_data.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class MealProvider implements Firestoration<String, Meal> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<Meal> add(Meal obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  addFakeDate() async {
    for (var meal in mealFakeData) {
      await add(meal);
    }
  }

  @override
  String get collectionPath => AppValue.mealsPath;

  @override
  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Meal> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<List<Meal>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<Meal> list = [];
    for (var element in raw.docs) {
      list.add(Meal.fromMap(element.id, element.data()));
    }

    return list;
  }

  @override
  Future<Meal> update(String id, Meal obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
