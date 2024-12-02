import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Modal/UserModal.dart';

/*
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



class DatabaseHelper {
  DatabaseHelper._();


  final String databaseName = "userInformation.db";
  final String tableName = "userInformation";

  static DatabaseHelper databaseHelper = DatabaseHelper._();

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


}*/
class DbHelper {
  DbHelper._();

  String databaseName = 'userData.db';
  String tableName = 'userData';

  static DbHelper dbHelper = DbHelper._();

  Database? _database;

  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
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
        age INTEGER NOT NULL,
        phone INTEGER NOT NULL,
        salary REAL NOT NULL
        )
        ''';
        await db.execute(sql);
      },
    );
    return _database;
  }

  Future<void> insertData(UserDataModal user) async {
    Database? db = await database;
    String sql = '''
    INSERT INTO $tableName (id,name,age,phone,salary)
    VALUES (?,?,?,?,?)
    ''';
    List args = [user.id, user.name, user.age, user.phone, user.salary];
    db!.rawInsert(sql, args);
  }

  Future<List<Map<String, dynamic>>> readData() async {
    Database? db = await database;

    String sql = "SELECT * FROM $tableName";
    return await db!.rawQuery(sql);
  }

  Future<void> updateData(UserDataModal user, int id) async {
    Database? db = await database;
    String sql = '''
    UPDATE $tableName SET id = ?, name = ?, age = ?, phone = ?, salary = ? WHERE id = ? 
  ''';

    List args = [user.id, user.name, user.age, user.phone, user.salary, id];
    await db!.rawUpdate(sql, args);
  }

  Future<void> deleteData(int id) async {
    Database? db = await database;
    String sql = "DELETE FROM $tableName WHERE id = ? ";
    List args = [id];
    await db!.rawDelete(sql, args);
  }

  // Future<List<Map<String, dynamic>>> liveSearch(String value) async {
  //   Database? db = await database;
  //   String sql = "SELECT * FROM $tableName WHERE name LIKE '%$value%'";
  //   // List args = [value];
  //   return await db!.rawQuery(sql);
  // }

  Future<List<Map<String, dynamic>>> searchData(String value) async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE name LIKE ?
    ''';
    List args = ['%$value%'];
    return await db!.rawQuery(sql, args);
  }
}
