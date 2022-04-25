import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/local_meal_nutrition.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class LocalMealProvider implements SqfliteHelper<int, LocalMealNutrition> {
  @override
  String tableName = AppValue.localMealTable;

  @override
  Future<void> add(LocalMealNutrition obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap());
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<LocalMealNutrition?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return LocalMealNutrition.fromMap(maps[0]);
  }

  @override
  Future<List<LocalMealNutrition>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => LocalMealNutrition.fromMap(maps[index]));
  }

  @override
  Future<List<LocalMealNutrition>> fetchByDate(DateTime dateTime) async {
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id, LocalMealNutrition obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
