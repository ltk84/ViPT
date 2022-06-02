import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/plan_meal.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class PlanMealProvider implements SqfliteHelper<int, PlanMeal> {
  @override
  String tableName = AppValue.planMealTable;

  @override
  Future<PlanMeal> add(PlanMeal obj) async {
    final db = await DatabaseProvider.database;
    await db!.insert(tableName, obj.toMap()).then((value) {
      return obj.id = value;
    });
    return obj;
  }

  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<PlanMeal?> fetch(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PlanMeal>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) => PlanMeal.fromMap(maps[index]));
  }

  @override
  Future<List<PlanMeal>> fetchByDate(DateTime dateTime) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id, PlanMeal obj) {
    throw UnimplementedError();
  }

  Future<void> deleteAll() async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName);
  }
}
