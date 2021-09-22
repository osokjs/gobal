import 'dart:io';
import 'package:gobal/model/favorite_data.dart';
import 'package:gobal/model/group_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "gobal.db";
  static final _databaseVersion = 1;

  // table names
  static final _groupTable = "groupCode";
  static final _favoritesTable = "favorites";
  static final _routeCodeTable = "routeCode";
  static final _routesTable = "routes";


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // factory DatabaseHelper() => _db;
  static late Database _database;

  Future<Database> get database async {
    // _database ??= await _initDatabase();

    if (_database != null) return _database;
      _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {

    print('---- create table starting...');
    // groupCode table
    await db.execute('''
          CREATE TABLE $_groupTable (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            Name text NOT NULL
          ) ''');

    print('-- groupCode table successfully created.');
// 그룹코드에 기본값 추가
    await insertGroupCode('일반');
    await insertGroupCode('집');
    await insertGroupCode('산책');
    print('-- default data are inserted into groupCode table successfully.');

    // favorites table
    await db.execute('''
          CREATE TABLE $_favoritesTable (
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            G_ID INTEGER default 1, 
            Name text NOT NULL,
            LATITUDE DOUBLE NOT NULL,
            LONGITUDE DOUBLE NOT NULL,
            ACCURACY DOUBLE NOT NULL,
            UPDATED TEXT
                      ) ''');
    print('-- favorites table successfully created.');

    // ROUTE CODE TABLE
    await db.execute('''
    CREATE TABLE $_routeCodeTable (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Name text NOT NULL,
      UPDATED TEXT
    ) ''');
    print('-- routeCode table successfully created.');

// ROUTES TABLE
    await db.execute('''
          CREATE TABLE $_routesTable (
            R_ID INTEGER NOT NULL,
            INDEX INTEGER NOT NULL,
            Name text NOT NULL,
            LATITUDE DOUBLE NOT NULL,
            LONGITUDE DOUBLE NOT NULL,
            ACCURACY DOUBLE NOT NULL,
            PRIMARY KEY (R_ID, INDEX)
          ) ''');
    print('-- routes table successfully created.');

  }


  // Data insert methods
  Future<int> insertGroupCode(String name) async {
    int result = 0;
    String _tableName =_groupTable;

    try {
      Database db = await DatabaseHelper.instance.database;
          result = await db.rawInsert(
              'INSERT INTO $_tableName (name) VALUES (?)',
              [name]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
    assert(result == 1);
    print('insert: $_tableName, $result rows.');
    return result;
  }

  Future<int> insertFavorite(FavoriteData fd) async {
    int result = 0;
    String _tableName = _favoritesTable;

    try {
      Database db = await DatabaseHelper.instance.database;
      result = await db.rawInsert(
          'INSERT INTO $_tableName (G_ID, NAME, LATITUDE, LONGITUDE, ACCURACY, UPDATED) VALUES (?, ?, ?, ?, ?, ?)',
          [fd.gId, fd.name, fd.latitude, fd.longitude, fd.accuracy, fd.updated]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
    assert(result == 1);
    print('insert: $_tableName, $result rows.');
    return result;
  }


  Future<List<GroupData>> getAllGroupCode() async {
    final String _tableName = _groupTable;
    Database db = await DatabaseHelper.instance.database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $_tableName ORDER BY NAME'
    );

    List<GroupData> list = result.isNotEmpty ?
    result.map((val) => GroupData(id: val['id'], name: val['name'])).toList()
        : []
    ;
    return list;
  }

  Future<int> deleteGroupCode(int id) async {
    final String _tableName = _groupTable;
    Database db = await DatabaseHelper.instance.database;
    int result = await db.rawDelete(
        'DELETE FROM $_tableName WHERE id = ?',
        [id]
    );
    assert(result == 1);
    return result;
  }

  Future<void> deleteAllGroupCode() async {
    final String _tableName = _groupTable;
    Database db = await DatabaseHelper.instance.database;
    await db.rawDelete(
        'DELETE FROM $_tableName'
    );
  }

  //Update
  Future<int>  updateGroupCode(GroupData data) async {
    final String _tableName = _groupTable;
    Database db = await DatabaseHelper.instance.database;
    int result = await db.rawUpdate(
        'UPDATE $_tableName SET name = ? WHERE ID = ?',
        [data.name, data.id]
    );
    assert(result == 1);
    return result;
  }


} // class DatabaseHelper
