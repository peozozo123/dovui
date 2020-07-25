import 'package:flutter/material.dart';

class HighScorePage extends StatelessWidget {
  String name;
  int score;
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image(image: AssetImage('assets/images/Crown.png')),
                  ),
                ),
                Text(
                  'High Score',
                  style: TextStyle(
                    fontFamily: 'PatrickHand',
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  data['score'].toString(),
                  style: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: 150,
                  ),
                ),
                Text(
                  data['name'],
                  style: TextStyle(
                    fontFamily: 'PatrickHand',
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 60,
                  minWidth: 100,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
