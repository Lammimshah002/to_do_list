import 'package:sqflite/sqflite.dart' as Sql;
import 'dart:async';
import 'tododatamodel.dart';

class lammim_note {
  static Future<void> createTables(Sql.Database database) async {
    await database.execute("""
    CREATE TABLE note (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      task Text,
      task1 Text,
      date Text,
      time Text,
      taskComplted BOOLEAN NOT NULL DEFAULT 0
    )""");
  }

  // Initialize database
  static Future<Sql.Database> db() async {
    return Sql.openDatabase(
      "database_name_note.db",
      version: 2,
      onCreate: (Sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Insert item
  static Future<int> addItem(String task, String task1,String date,String time) async {
    final db = await lammim_note.db();
    final data = {'task': task, 'task1': task1, 'date': date,'time': time,'taskComplted': false};
    final id = await db.insert('note', data,
        conflictAlgorithm: Sql.ConflictAlgorithm.ignore);
    print('add ki hoyche');
    return id;
  }

  // Fetch all items
  static Future<List<datamodel>> read() async {
    final db = await lammim_note.db();
    final List<Map<String, dynamic>> maps = await db.query('note');
    return List.generate(maps.length, (i) {
      return datamodel(
        id: maps[i]['id'],
        task: maps[i]['task'],
        task1: maps[i]['task1'],
        taskComplted: maps[i]['taskComplted'] == 1,
        date: maps[i]['date'],
        time: maps[i]['time'],
      );
    });
  }

  // Delete item
  static Future<int> delete(int id) async {
    print("delet item");
    print("$id");
    final db = await lammim_note.db();
    return await db.delete('note', where: "id = ?", whereArgs: [id]);
  }

  // Update item (toggle completion status)
  static Future<int> updateTaskStatus( bool isCompleted, int id) async {
    final db = await lammim_note.db();
    return await db.update('note', {'taskComplted': isCompleted ? 1 : 0},
        where: "id = ?", whereArgs: [id]);
  }
}

// Data model
