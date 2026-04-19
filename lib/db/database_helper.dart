import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gasto.dart';

class DatabaseHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'flowcash.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE gastos(id INTEGER PRIMARY KEY AUTOINCREMENT, valor REAL, motivo TEXT, dia TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertGasto(Gasto gasto) async {
    final db = await getDatabase();
    await db.insert('gastos', gasto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Gasto>> getGastos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('gastos');
    return List.generate(maps.length, (i) => Gasto.fromMap(maps[i]));
  }

  static Future<void> updateGasto(Gasto gasto) async {
    final db = await getDatabase();
    await db.update('gastos', gasto.toMap(),
        where: 'id = ?', whereArgs: [gasto.id]);
  }

  static Future<void> deleteGasto(int id) async {
    final db = await getDatabase();
    await db.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }
}
