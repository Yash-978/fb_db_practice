// import 'package:get/get.dart';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

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

  static DbHelper dbHelper = DbHelper._();
  String databaseName = 'userData.db';
  String tableName = 'userData';

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

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();
  String databaseName = "databaseName.db";
  String tableName = "tableName";

  Database? _database;

// Future<Database?> get database async => _database ?? await initDatabase();
  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbpath = join(path, databaseName);

    _database = await openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        number TEXT,
        
        
        )
        ''';
        db.execute(sql);
      },
    );
    return _database;
  }
}

class DataHelper {
  // Singleton Instance
  DataHelper._();

  static final DbHelper instance = DbHelper._();

  // Database Properties
  static const String _databaseName = 'userData.db';
  static const String _tableName = 'userData';
  Database? _database;

  // Getter for Database (Lazy Initialization)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize Database
  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            age INTEGER NOT NULL,
            phone INTEGER NOT NULL,
            salary REAL NOT NULL
          )
        ''');
      },
    );
  }

  // Insert Data
  Future<void> insertData(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(_tableName, user);
  }

  // Read Data
  Future<List<Map<String, dynamic>>> readData() async {
    final db = await database;
    return await db.query(_tableName);
  }

  // Update Data
  Future<void> updateData(Map<String, dynamic> user, int id) async {
    final db = await database;
    await db.update(
      _tableName,
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete Data
  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search Data
  Future<List<Map<String, dynamic>>> searchData(String query) async {
    final db = await database;
    return await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }
}

class ApiHelper {
  Future<List> fetchData() async {
    String api = '';
    Uri url = Uri.parse(api);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      final List data = jsonDecode(json);
      return data;
    } else {
      return [];
    }
  }
}

class LocalDatabaseHelper {
  LocalDatabaseHelper._();

  static LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper._();

  String databaseName = 'databaseName.db';
  String tableName = 'tableName';

  Database? _database;

//Future<Database?> get database async => _database ?? await initDatabase();
  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);

    _database = await openDatabase(
      version: 1,
      dbPath,
      onCreate: (db, version) async {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        name TEXT,
        surname TEXT,
        fatherName TEXT
        )
        ''';
        await db.execute(sql);
      },
    );

    return _database;
  }

  Future<void> insertData() async {
    Database? db = await database;
    // db.insert(tableName, );
  }
}
