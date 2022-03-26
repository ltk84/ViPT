import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/providers/firestoration.dart';

class IngredientProvider implements Firestoration<String, Ingredient> {
  @override
  Future<Ingredient> add(Ingredient obj) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  // TODO: implement collectionPath
  String get collectionPath => AppValue.mealIngredientsPath;

  @override
  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Ingredient> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Ingredient> update(String id, Ingredient obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
