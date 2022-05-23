import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/plan_exercise.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class PlanExerciseProvider implements SqfliteHelper<int, PlanExercise> {
  @override
  String tableName = AppValue.planExerciseTable;

  @override
  Future<PlanExercise?> add(PlanExercise obj) async {
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
  Future<PlanExercise?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return PlanExercise.fromMap(maps[0]);
  }

  @override
  Future<List<PlanExercise>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => PlanExercise.fromMap(maps[index]));
  }

  @override
  Future<List<PlanExercise>> fetchByDate(DateTime dateTime) async {
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
        maps.length, (index) => PlanExercise.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, PlanExercise obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
