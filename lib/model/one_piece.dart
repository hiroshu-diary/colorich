import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OnePiece {
  late int oneId;
  late int oneRed;
  late int oneGreen;
  late int oneBlue;
  late DateTime oneTime;
  late String? oneStory;

  OnePiece(
    this.oneId,
    this.oneRed,
    this.oneGreen,
    this.oneBlue,
    this.oneTime,
    this.oneStory,
  );
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //     'oneId': oneId,
  //     'oneRed': oneRed,
  //     'oneGreen': oneGreen,
  //     'oneBlue': oneBlue,
  //     'oneTime': oneTime,
  //     'oneStory': oneStory,
  //   };
  // }
  //
  // static Future<Database> get database async {
  //   // openDatabase() データベースに接続
  //   final Future<Database> _database = openDatabase(
  //     // getDatabasesPath() データベースファイルを保存するパス取得
  //     join(await getDatabasesPath(), 'colorich.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         // テーブルの作成
  //         "CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT)",
  //       );
  //     },
  //     version: 1,
  //   );
  //   return _database;
  // }
}
