import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void getHighScore(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('name')) {
    prefs.setInt('score', 0);
    prefs.setString('name', 'Chưa có người chơi');
  }
  Navigator.pushNamed(context, '/highscore', arguments: {
    'name': prefs.getString('name'),
    'score': prefs.getInt('score'),
  });
}
