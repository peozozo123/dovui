import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:dovui/quizpage.dart';
import 'package:dovui/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'loading.dart';
import 'true.dart';
import "end.dart";
import 'highscore.dart';

final cache = AudioCache(prefix: 'audios/');
AudioPlayer player;

class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      player?.resume();
    } else {
      player?.pause();
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(initialRoute: '/loading', routes: {
    '/loading': (context) => Loading(),
    '/home': (context) => Home(),
    '/quizpage': (context) => QuizPage(),
    '/truepage': (context) => TruePage(),
    '/endpage': (context) => EndPage(),
    '/highscore': (context) => HighScorePage(),
  }));
  cache.load('audio.mp3');
  player = await cache.loop('audio.mp3');
  WidgetsBinding.instance.addObserver(new _Handler());
}
