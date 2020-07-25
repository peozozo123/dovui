import 'package:flutter/material.dart';

class TruePage extends StatefulWidget {
  @override
  _TruePageState createState() => _TruePageState();
}

class _TruePageState extends State<TruePage> {
  Map data = {};
  Map currentSession = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    data['currentSession']['score']++;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                alignment: Alignment.center,
                child: Text(
                  data['data'][data['currentSession']['qq']]['g'],
                  style: TextStyle(
                    fontFamily: 'PatrickHand',
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image(
              image: AssetImage('assets/images/VvdFMUC.gif'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/quizpage',
                        arguments: {
                          'data': data['data'],
                          'highscore': data['highscore'],
                          'currentSession': data['currentSession'],
                        });
                  },
                  child: Text("Hỏi tiếp đê",
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 24.0,
                      )),
                  minWidth: 200,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
