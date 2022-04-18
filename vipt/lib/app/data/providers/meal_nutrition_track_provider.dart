import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

import 'database_provider.dart';

class MealNutritionTrackProvider
    implements SqfliteHelper<int, MealNutritionTracker> {
  @override
  String tableName = AppValue.mealNutritionTrackTable;

  @override
  Future<void> add(MealNutritionTracker obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap());
  }

  @override
  Future<void> delete(int id) async {
    final db = await DatabaseProvider.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<MealNutritionTracker?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return MealNutritionTracker.fromMap(maps[0]);
  }

  @override
  Future<List<MealNutritionTracker>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => MealNutritionTracker.fromMap(maps[index]));
  }

  @override
  Future<List<MealNutritionTracker>> fetchByDate(DateTime dateTime) async {
    final db = await DatabaseProvider.database;
    String date = DateUtils.dateOnly(dateTime).toString();
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'date = ?', whereArgs: [date]);
    if (maps.isEmpty) return [];
    return List.generate(
        maps.length, (index) => MealNutritionTracker.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, MealNutritionTracker obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }
}