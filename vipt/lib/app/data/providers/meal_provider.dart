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
    throw UnimplementedError();
  }

  @override
  Future<Meal> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Meal.fromMap(raw.id, raw.data() ?? {});
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

  Future<String> fetchByName(String name) async {
    String result = "";
    await _firestore
        .collection(collectionPath)
        .where('name', isEqualTo: name)
        .get()
        .then((value) => result = value.docs.first.id);
    return result;
  }

  @override
  Future<Meal> update(String id, Meal obj) {
    throw UnimplementedError();
  }
}
