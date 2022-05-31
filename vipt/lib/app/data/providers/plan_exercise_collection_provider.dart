import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/plan_exercise_collection.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class PlanExerciseCollectionProvider
    implements SqfliteHelper<int, PlanExerciseCollection> {
  @override
  String tableName = AppValue.planExerciseCollectionTable;

  @override
  Future<PlanExerciseCollection> add(PlanExerciseCollection obj) async {
    final db = await DatabaseProvider.database;
    await db!.insert(tableName, obj.toMap()).then((value) {
      return obj.id = value;
    });
    return obj;
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<PlanExerciseCollection?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return PlanExerciseCollection.fromMap(maps[0]);
  }

  @override
  Future<List<PlanExerciseCollection>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => PlanExerciseCollection.fromMap(maps[index]));
  }

  @override
  Future<List<PlanExerciseCollection>> fetchByDate(DateTime dateTime) async {
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
        maps.length, (index) => PlanExerciseCollection.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, PlanExerciseCollection obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
