import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/streak.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class StreakProvider implements SqfliteHelper<int, Streak> {
  @override
  String tableName = AppValue.planStreakTable;

  @override
  Future<Streak> add(Streak obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap()).then((value) => obj.id = value);
    return obj;
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Streak?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Streak.fromMap(maps[0]);
  }

  @override
  Future<List<Streak>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) => Streak.fromMap(maps[index]));
  }

  Future<List<Streak>> fetchByPlanID(int planID) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: "planID = ?", whereArgs: [planID]);

    return List.generate(maps.length, (index) => Streak.fromMap(maps[index]));
  }

  @override
  Future<List<Streak>> fetchByDate(DateTime dateTime) async {
    final db = await DatabaseProvider.database;
    final String begin =
        DateTime(dateTime.year, dateTime.month, dateTime.day).toString();
    final String end = DateTime(
            dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 59, 59)
        .toString();
    final List<Map<String, dynamic>> maps = await db!.query(tableName,
        where: 'date >= ? and date <= ?', whereArgs: [begin, end]);
    if (maps.isEmpty) return [];
    return List.generate(maps.length, (index) => Streak.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, Streak obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName);
  }
}
