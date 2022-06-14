import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_plan.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class WorkoutPlanProvider implements SqfliteHelper<int, WorkoutPlan> {
  @override
  String tableName = AppValue.workoutPlanTable;

  @override
  Future<WorkoutPlan> add(WorkoutPlan obj) async {
    final db = await DatabaseProvider.database;
    await db!.insert(tableName, obj.toMap()).then((value) => obj.id = value);
    return obj;
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<WorkoutPlan?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return WorkoutPlan.fromMap(maps[0]);
  }

  Future<WorkoutPlan?> fetchByUserID(String userId) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'userID = ?', whereArgs: [userId]);
    if (maps.isEmpty) return null;
    return WorkoutPlan.fromMap(maps[0]);
  }

  @override
  Future<List<WorkoutPlan>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => WorkoutPlan.fromMap(maps[index]));
  }

  @override
  Future<List<WorkoutPlan>> fetchByDate(DateTime dateTime) async {
    final db = await DatabaseProvider.database;
    final String begin =
        DateTime(dateTime.year, dateTime.month, dateTime.day).toString();
    final String end = DateTime(
            dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 59, 59)
        .toString();
    final List<Map<String, dynamic>> maps = await db!.query(tableName,
        where: 'date >= ? and date <= ?', whereArgs: [begin, end]);
    if (maps.isEmpty) return [];
    return List.generate(
        maps.length, (index) => WorkoutPlan.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, WorkoutPlan obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName);
  }
}
