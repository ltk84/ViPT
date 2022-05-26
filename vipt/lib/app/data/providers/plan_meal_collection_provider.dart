import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/plan_meal_collection.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class PlanMealCollectionProvider
    implements SqfliteHelper<int, PlanMealCollection> {
  @override
  String tableName = AppValue.planMealCollectionTable;

  @override
  Future<PlanMealCollection?> add(PlanMealCollection obj) async {
    final db = await DatabaseProvider.database;
    await db!.insert(tableName, obj.toMap()).then((value) {
      return obj.id = value;
    });
    return obj;
  }

  @override
  Future<void> delete(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<PlanMealCollection?> fetch(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PlanMealCollection>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => PlanMealCollection.fromMap(maps[index]));
  }

  @override
  Future<List<PlanMealCollection>> fetchByDate(DateTime dateTime) async {
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id, PlanMealCollection obj) async {
    throw UnimplementedError();
  }
}
