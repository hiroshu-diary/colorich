import 'package:colorich/model/one_piece.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? database;
  static const String tableName = 'colorTiles';

  static Future<void> _createTable(Database db, int version) async {
    //AUTOINCREMENTを使うことで、idを自動で追加する
    await db.execute(
      'CREATE TABLE $tableName(oneId INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' oneRed INTEGER, oneGreen INTEGER, oneBlue INTEGER, oneTime TEXT,'
      ' oneStory TEXT)',
    );
  }

  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'colorich.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  static Future<Database?> setDb() async {
    if (database == null) {
      database = await initDb();
    } else {
      return database;
    }
  }

  //CREATE
  static Future<int> create(OnePiece onePiece) async {
    await database!.insert(tableName, {
      'oneRed': onePiece.oneRed,
      'oneGreen': onePiece.oneGreen,
      'oneBlue': onePiece.oneBlue,
      'oneTime': onePiece.oneTime.toString(),
      'oneStory': onePiece.oneStory,
    });
    final List<Map<String, dynamic>> maps = await database!.query(tableName);
    return maps.last['oneId'];
  }

  //READ
  static Future<List<OnePiece>> read() async {
    final List<Map<String, dynamic>> maps = await database!.query(tableName);
    if (maps.isEmpty) {
      return [];
    } else {
      List<OnePiece> timeLine = List.generate(maps.length, (index) {
        return OnePiece(
          maps[index]['oneId'],
          maps[index]['oneRed'],
          maps[index]['oneGreen'],
          maps[index]['oneBlue'],
          DateTime.parse(maps[index]['oneTime']),
          maps[index]['oneStory'],
        );
      });
      return timeLine;
    }
  }

  //UPDATE
  static Future<void> update(OnePiece onePiece) async {
    await database!.update(
      tableName,
      {
        'oneRed': onePiece.oneRed,
        'oneGreen': onePiece.oneGreen,
        'oneBlue': onePiece.oneBlue,
        'oneTime': onePiece.oneTime.toString(),
        'oneStory': onePiece.oneStory,
      },
      //被りがないののはidだから使用
      where: 'oneId = ?',
      whereArgs: [onePiece.oneTime],
      //alarm.idとidが一致した時に上記のようにアップデートする
    );
  }

  //DELETE
  static Future<void> delete(int oneId) async {
    await database!.delete(tableName, where: 'oneId = ?', whereArgs: [oneId]);
  }
}
