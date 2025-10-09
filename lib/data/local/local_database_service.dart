import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = "restaurant-app.db";
  static const String _tableName = "restaurant";
  static const int _databaseVersion = 1;

  Future<void> createTables(Database database) async {
    await database.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        city TEXT,
        address TEXT,
        pictureId TEXT,
        categories TEXT,
        menus TEXT,
        rating REAL,
        customerReviews TEXT
      )
    ''');
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    data["categories"] = jsonEncode(data["categories"]);
    data["menus"] = jsonEncode(data["menus"]);
    data["customerReviews"] = jsonEncode(data["customerReviews"]);

    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<Restaurant>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) {
      return Restaurant.fromJson({
        ...result,
        "categories": jsonDecode((result["categories"] ?? "[]").toString()),
        "menus": jsonDecode((result["menus"] ?? "{}").toString()),
        "customerReviews": jsonDecode(
          (result["customerReviews"] ?? "[]").toString(),
        ),
      });
    }).toList();
  }

  Future<Restaurant?> getItemById(String id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;

    final result = results.first;
    return Restaurant.fromJson({
      ...result,
      "categories": jsonDecode((result["categories"] ?? "[]").toString()),
      "menus": jsonDecode((result["menus"] ?? "{}").toString()),
      "customerReviews": jsonDecode(
        (result["customerReviews"] ?? "[]").toString(),
      ),
    });
  }

  Future<String> removeItem(String id) async {
    final db = await _initializeDb();
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

    return id;
  }
}
