import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREATE TABLE imc (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    peso REAL,
    altura REAL,
    classificacao TEXT
  );''',
};

class DataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    }
    return db!;
  }

  Future iniciarBancoDeDados() async {
    var db = openDatabase(path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });
    return db;
  }
}
