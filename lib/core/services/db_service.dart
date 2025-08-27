import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/database_const.dart';

class DbService {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), dbName),
        version: databaseVersion,
        onCreate: _onCreate,
        onDowngrade: onDatabaseDowngradeDelete,
      );
    } catch (e) {
      // _log.warning('❌ Database init error: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $recipesTableName(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT,
            $columnIngredients TEXT,
            $columnIsFavorite INTEGER DEFAULT 0,
            $columnCookIt INTEGER DEFAULT 0,
            $columnImage TEXT,
            $columnCategoryId INTEGER NOT NULL,
            $columnDate TEXT DEFAULT current_date
          )
    ''');
    await db.execute('''
      CREATE TABLE $categoryTableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnParentCategoryId INTEGER DEFAULT 0
      )
      ''');
  }


}