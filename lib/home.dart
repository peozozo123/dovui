import 'package:dovui/services/getHighScore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:audioplayers/audio_cache.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final player = AudioCache(prefix: 'audios/');

  void getData(BuildContext context) async {
    var databasesPath = await getDatabasesPath();
    var path = Path.join(databasesPath, "data.db");
    Database db = await openDatabase(path);
    List<Map> list = await db.rawQuery('SELECT * FROM questions');
    Navigator.pushReplacementNamed(context, '/quizpage', arguments: {
      'data': list,
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image(
                  height: 200,
                  width: 200,
                  image: AssetImage('assets/images/023.png'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        getData(context);
                      },
                      child: Text(
                        'Bắt đầu',
                        style: TextStyle(
                          fontFamily: 'PatrickHand',
                          fontSize: 40.0,
                        ),
                      ),
                      height: 60.0,
                      minWidth: 300.0,
                      color: Colors.red[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        getHighScore(context);
                      },
                      child: Text(
                        'Điểm cao',
                        style: TextStyle(
                          fontFamily: 'PatrickHand',
                          fontSize: 40.0,
                        ),
                      ),
                      height: 60.0,
                      minWidth: 300.0,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
