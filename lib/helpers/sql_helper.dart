import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SQLHelper {
  static Future<Database> database() async {
    //const int currentVersion = 1;
    //const int newVersion = 2;
    final dbPath = await sql
        .getDatabasesPath(); // to get available path from user device to store data
    return sql.openDatabase(
      path.join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE keep_note(id TEXT PRIMARY KEY, title TEXT, description TEXT)');
      },
      /* onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await migrateDatabase(db);
        }
      }, */
      version: 1,
    );
  }

  //
  //
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await SQLHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //
  //
  //
  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await SQLHelper.database();
    db.rawUpdate('UPDATE $table SET title = ?, description = ? WHERE id = ?',
        [data['title'], data['description'], data['id']]);
  }

  //
  //
  //
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SQLHelper.database();
    return db.query(table);
  }

  //
  //
  //
  static Future<void> deleteSingleNote(String table, String id) async {
    final db = await SQLHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteTable(String tableName) async {
    final db = await SQLHelper.database();
    await db.delete(tableName);
  }

  /* static Future<void> migrateDatabase(
    Database database,
  ) async {
    await database.insert('keep_note', {'title': 'Jaimin'});
  } */
}
