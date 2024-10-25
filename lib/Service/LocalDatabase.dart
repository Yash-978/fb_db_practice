import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Modal/UserModal.dart';

class DbHelper {
  DbHelper._();

  final String databaseName = "userInformation.db";
  final String tableName = "userInformation";

  static DbHelper dbHelper = DbHelper._();

  Database? _database;

  //Create
  Future<Database?> get database async => _database ?? await createDatabase();

  Future<Database?> createDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL
        )
    ''';
        await db.execute(sql);
      },
    );
    return _database;
  }

  //insert
  Future<void> insertData(UserInfoModal userInfo) async {
    Database? db = await database;
    String sql =
        '''INSERT INTO $tableName (id,name,email,phone) VALUES (?,?,?,?)
    ''';
    List args = [userInfo.id, userInfo.name, userInfo.email, userInfo.phone];
    await db!.rawInsert(sql, args);
    print('sql document added');
  }

  //Read
  Future<List<Map<String, dynamic>>> readData() async {
    Database? db = await database;
    String sql = "SELECT * FROM $tableName";
    return await db!.rawQuery(sql);
  }

  // Update
  Future<void> updateSqlData(UserInfoModal userInfo, int id) async {
    Database? db = await database;
    String sql = '''
    UPDATE $tableName SET id = ?,name = ? , email = ? , phone = ? WHERE id = ? 
    ''';
    List args = [userInfo.id, userInfo.name, userInfo.email, userInfo.phone];
    await db!.rawUpdate(sql, args);
  }


}


