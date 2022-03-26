import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class IngredientProvider implements Firestoration<String, Ingredient> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Ingredient> add(Ingredient obj) async {
    await _firestore
        .collection(collectionPath)
        .add(obj.toMap())
        .then((value) => obj.id = value.id);
    return obj;
  }

  @override
  String get collectionPath => AppValue.mealIngredientsPath;

  @override
  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Ingredient> fetch(String id) async {
    final raw = await _firestore.collection(collectionPath).doc(id).get();
    return Ingredient.fromMap(raw.id, raw.data() ?? {});
  }

  @override
  Future<Ingredient> update(String id, Ingredient obj) async {
    await _firestore.collection(collectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  @override
  Future<List<Ingredient>> fetchAll() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection(collectionPath).get();

    List<Ingredient> list = [];
    for (var element in raw.docs) {
      list.add(Ingredient.fromMap(element.id, element.data()));
    }

    return list;
  }
}
