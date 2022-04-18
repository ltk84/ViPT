import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/local_meal.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class LocalMealProvider implements SqfliteHelper<int, LocalMeal> {
  @override
  String tableName = AppValue.localMealTable;

  @override
  Future<void> add(LocalMeal obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap());
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<LocalMeal?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return LocalMeal.fromMap(maps[0]);
  }

  @override
  Future<List<LocalMeal>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => LocalMeal.fromMap(maps[index]));
  }

  @override
  Future<List<LocalMeal>> fetchByDate(DateTime dateTime) async {
    // TODO: implement fetchByDate
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id, LocalMeal obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
