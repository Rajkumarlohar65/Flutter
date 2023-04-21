import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user_details_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  static const String tableUserDetails = 'user_details';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnEmail = 'email';
  static const String columnAge = 'age';

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_details.db');

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUserDetails (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT,
        $columnEmail TEXT,
        $columnAge INTEGER
      )
    ''');
  }

  Future<int> insert(UserDetails userDetails) async {
    final db = await database;
    return db.insert(tableUserDetails, userDetails.toJson());
  }

  Future<List<UserDetails>> get() async {
    final db = await database;
    final result = await db.query(tableUserDetails);

    return result.map((json) => UserDetails.fromJson(json)).toList();
  }

  Future<int> update(UserDetails userDetails) async {
    final db = await database;
    return db.update(
      tableUserDetails,
      userDetails.toJson(),
      where: '$columnId = ?',
      whereArgs: [userDetails.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(
      tableUserDetails,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
