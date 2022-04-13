import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/providers/database_provider.dart';
import 'package:vipt/app/data/providers/sqflite_helper.dart';

class WaterTrackProvider implements SqfliteHelper<int, WaterTracker> {
  @override
  Future<void> add(WaterTracker obj) async {
    final db = await DatabaseProvider.database;
    db!.insert(tableName, obj.toMap());
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
  String tableName = 'WaterTrackRecord';
}
