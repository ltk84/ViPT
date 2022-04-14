import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/providers/database_provider.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

class ExerciseTrackProvider implements SqfliteHelper<int, ExerciseTracker> {
  @override
  String tableName = AppValue.exerciseTrackTable;

  @override
  Future<void> add(ExerciseTracker obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap());
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<ExerciseTracker?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return ExerciseTracker.fromMap(maps[0]);
  }

  @override
  Future<List<ExerciseTracker>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => ExerciseTracker.fromMap(maps[index]));
  }

  @override
  Future<ExerciseTracker?> fetchByDate(DateTime dateTime) async {
    final db = await DatabaseProvider.database;
    String date = DateUtils.dateOnly(dateTime).toString();
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'date = ?', whereArgs: [date]);
    if (maps.isEmpty) return null;
    return ExerciseTracker.fromMap(maps[0]);
  }

  @override
  Future<void> update(int id, ExerciseTracker obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}
