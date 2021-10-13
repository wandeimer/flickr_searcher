import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class FavoriteListDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialize();
    }
    return _database!;
  }

  FavoriteListDatabase();

  initialize() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    var path = join(documentsDir.path, "db.db");
    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE Favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT)");
        });
  }

  Future<List<String>> getAllImages() async {
    Database db = await database;
    List<Map> query =
    await db.rawQuery("SELECT * FROM Favorite ORDER BY id DESC");
    List<String> result = [];
    query.forEach((r) => result.add(r["image"]));
    return result;
  }

  Future<void> addImage(String image) async {
    Database db = await database;
    db.rawInsert(
        "INSERT INTO Favorite (image) VALUES (\"$image\")");
  }

  Future<void> deleteImage(String image) async {
    Database db = await database;
    db.rawDelete("DELETE FROM Favorite WHERE image = ?", ["$image"]);
  }

}
