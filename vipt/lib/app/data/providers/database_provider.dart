import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vipt/app/core/values/values.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static const String dbName = 'vipt_trackers_database.db';

  static final DatabaseProvider instance = DatabaseProvider._();
  // static Database _database;

  static Database? _database;

  static Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await open();
    return _database;
  }

  static Future<Database> open() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: 1,
      onCreate: (db, version) async => _createDB(db),
    );
  }

  static _createDB(Database db) async {
    db.execute('''
      CREATE TABLE ${AppValue.waterTrackTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        waterVolume INTEGER)
    ''');

    db.execute(''' 
    CREATE TABLE ${AppValue.exerciseTrackTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        outtakeCalories INTEGER,
        sessionNumber INTEGER,
        totalTime INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.mealNutritionTrackTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        date TEXT,
        intakeCalories INTEGER,
        carbs INTEGER,
        protein INTEGER,
        fat INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.localMealTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        calories INTEGER,
        carbs INTEGER,
        protein INTEGER,
        fat INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.weightTrackTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        weight INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.stepTrackTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        stepCount INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.workoutPlanTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dailyGoalCalories REAL,
        startDate TEXT,
        endDate TEXT)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.planExerciseCollectionTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        collectionSettingID INTEGER)
    ''');

    db.execute('''
      CREATE TABLE ${AppValue.planExerciseTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exerciseID TEXT,
        listID INTEGER)
    ''');

    // db.execute('''
    //   CREATE TABLE ${AppValue.workoutPlanMealTable}(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     date TEXT,
    //     mealID TEXT)
    // ''');

    db.execute('''
      CREATE TABLE ${AppValue.planExerciseCollectionSettingTable}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        round INTEGER,
        numOfWorkoutPerRound INTEGER,
        isStartWithWarmUp INTEGER,
        isShuffle INTEGER,
        exerciseTime INTEGER,
        transitionTime INTEGER,
        restTime INTEGER,
        restFrequency INTEGER)
    ''');
  }
}
