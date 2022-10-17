import 'package:sqflite/sqflite.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';

//CLASS DATA BASES
class DioDatabase {
  DioDatabase._instance();

  static final DioDatabase dioBases = DioDatabase._instance();
  static Database? _myDatabase;
  factory DioDatabase() => dioBases;

  static const String _tblFavorite = 'favorites';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _pictureId = 'pictureId';
  static const String _city = 'city';
  static const String _rating = 'rating';

  Future<Database?> get database async {
    if (_myDatabase != null) {
      return _myDatabase;
    }
    _myDatabase = await _initializeDioBases();
    return _myDatabase;
  }

  Future<Database> _initializeDioBases() async {
    var dioPath = await getDatabasesPath();
    var dioBases = openDatabase(
      '$dioPath/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite(
          $_id TEXT PRIMARY KEY, 
          $_name TEXT, 
          $_city TEXT,
          $_pictureId TEXT,
          $_rating REAL
          )''');
      },
      version: 1,
    );
    return dioBases;
  }

  insertFavorite(DioModel restaurant) async {
    final dioBases = await database;
     dioBases!.insert(
      _tblFavorite,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DioModel>> getFavorites() async {
    final dioBases = await database;
    var results = await dioBases!.query(_tblFavorite);
    if (results.isEmpty) {
      return [];
    } else {
      var resultDioToMap = results
          .map((restaurant) => DioModel.fromJson(restaurant))
          .toList();
      return resultDioToMap.isNotEmpty ? resultDioToMap : [];
    }
  }

  Future<Map<String, dynamic>> getFavoriteByUrl(String id) async {
    final dioBases = await database;

    List<Map<String, dynamic>> results = await dioBases!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> dioNotFavorite(String id) async {
    final dioBases = await database;
    await dioBases!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
