import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/providers/database_provider.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

class WaterTrackProvider implements SqfliteHelper<int, WaterTracker> {
  @override
  Future<WaterTracker> add(WaterTracker obj) async {
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
  Future<WaterTracker?> fetch(int id) async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return WaterTracker.fromMap(maps[0]);
  }

  @override
  Future<List<WaterTracker>> fetchByDate(DateTime dateTime) async {
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
        maps.length, (index) => WaterTracker.fromMap(maps[index]));
  }

  @override
  Future<List<WaterTracker>> fetchAll() async {
    final db = await DatabaseProvider.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(
        maps.length, (index) => WaterTracker.fromMap(maps[index]));
  }

  @override
  Future<void> update(int id, WaterTracker obj) async {
    final db = await DatabaseProvider.database;
    await db!.update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  @override
  String tableName = AppValue.waterTrackTable;
}
