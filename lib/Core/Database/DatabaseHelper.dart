import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  //will insure that we return one and only one instance instead
  //of creating a new instance.
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'LOK-ey.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate,onConfigure: _onConfigure);
  }
  void _onConfigure(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        color TEXT,
        icon TEXT,
        description TEXT,
        created_at INTEGER,
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Passwords (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        site TEXT,
        auth TEXT,
        password TEXT,
        icon TEXT,
        category_id INTEGER,
        created_at INTEGER,
        updated_at INTEGER,
        FOREIGN KEY (category_id) REFERENCES Categories(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardNumber TEXT,
        cardHolder TEXT,
        validThru TEXT,
        cardType TEXT,
        colorTop TEXT,
        colorBottom TEXT,
        created_at INTEGER
      )
    ''');
  }




  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await database;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row, String tableName,
      {required String where, required List<dynamic> whereArgs}) async {
    Database db = await database;
    return await db.update(tableName, row, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String tableName,
      {required String where, required List<dynamic> whereArgs}) async {
    Database db = await database;

    int affectedRows = 0;
    try {
      affectedRows = await db.delete(tableName, where: where, whereArgs: whereArgs);
    } catch (e) {
      print('Error deleting record: $e');
    }
    return affectedRows;
  }
}
