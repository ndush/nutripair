import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'meals.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE meals(id INTEGER PRIMARY KEY, title TEXT, nutritionalInfo TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMeal(Map<String, dynamic> meal) async {
    final db = await database;
    await db.insert('meals', meal);
  }

  Future<void> deleteMeal(int id) async {
    final db = await database;
    await db.delete('meals', where: 'id = ?', whereArgs: [id]);
  }
  Future<List<Map<String, dynamic>>> getLoggedMeals() async {
    final db = await database;
    return await db.query('meals');
  }
}
