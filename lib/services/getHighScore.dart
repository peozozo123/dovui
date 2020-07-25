import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

void getHighScore(BuildContext context) async {
  var databasesPath = await getDatabasesPath();
  var path = Path.join(databasesPath, "data.db");
  Database db = await openDatabase(path);
  List<Map> highscore = await db.rawQuery('SELECT * FROM highscore');
  Navigator.pushNamed(context, '/highscore', arguments: {
    'name': highscore[0]['name'],
    'score': highscore[0]['score'],
  });
}
