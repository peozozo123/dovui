import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

List<int> shuffleQuestions(int n) {
  var list = new List<int>.generate(100, (index) => index + 1);
  list.shuffle();
  return list;
}

class _QuizPageState extends State<QuizPage> {
  Map data = {};
  bool flag = true;
  Map currentSession = {};
  int qq;
  Map isEnable = {'a': true, 'b': true, 'c': true, 'd': true};

  toTheEndPage() async {
    bool f = false;
    if (currentSession['score'] > data['highscore'][0]['score']) {
      f = true;
    }
    Navigator.pushReplacementNamed(context, '/endpage', arguments: {
      'score': currentSession['score'],
      'data': data['data'],
      'flag': f,
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Bạn có muốn quay trờ về màn hình chính chứ ?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Không')),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text('Có')),
            ],
          );
        });
  }

  void checkanswer(String a) {
    if (a == data['data'][qq]['answer'].toString()) {
      currentSession['qq'] = qq;
      Navigator.pushReplacementNamed(context, '/truepage', arguments: {
        'data': data['data'],
        'highscore': data['highscore'],
        'currentSession': currentSession,
      });
    } else {
      setState(() {
        currentSession['maxFalse']--;
        if (currentSession['maxFalse'] == 0) toTheEndPage();
        isEnable[a] = false;
      });
    }
  }

  Widget choicebutton(String a) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: MaterialButton(
        onPressed: isEnable[a] ? () => checkanswer(a) : null,
        child: Text(
          data['data'][qq][a].toString(),
          style: TextStyle(
            fontFamily: 'PatrickHand',
            fontSize: 20.0,
          ),
        ),
        height: 80.0,
        minWidth: 300.0,
        color: Colors.blue[300],
        disabledColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    if (flag) {
      flag = false;
      if (!data.containsKey('currentSession')) {
        currentSession.addAll({
          'maxFalse': 5,
          'score': 0,
          'list': shuffleQuestions(data['data'].length)
        });
      } else
        currentSession = data['currentSession'];
    }
    qq = currentSession['list'][currentSession['score']];
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          currentSession['score'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.red[600],
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          currentSession['maxFalse'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 16,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      child: Text(
                        data['data'][qq]['q'].toString(),
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
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    alignment: Alignment.bottomLeft,
                    child: Image(
                      image: AssetImage('assets/images/do76WLV.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              child: Table(children: [
                TableRow(children: [
                  choicebutton('a'),
                  choicebutton('b'),
                ]),
                TableRow(children: [
                  choicebutton('c'),
                  choicebutton('d'),
                ]),
              ]),
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                alignment: Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.blue[300], // inkwell color
                      child: SizedBox(
                          width: 56, height: 56, child: Icon(Icons.arrow_back)),
                      onTap: () {
                        _showMyDialog();
                      },
                    ),
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
