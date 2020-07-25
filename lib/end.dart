import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class EndPage extends StatefulWidget {
  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  int highscore;

  bool flag;

  Map data = {};

  bool isDisable = false;

  final mycontroller = TextEditingController();

  saveScore() async {
    var databasesPath = await getDatabasesPath();
    var path = Path.join(databasesPath, "data.db");
    Database db = await openDatabase(path);
    db.rawQuery("UPDATE highscore SET name='" +
        mycontroller.text +
        "', score=" +
        data['score'].toString());
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    flag = data['flag'];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[200],
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
                        flag ? 'Điểm cao! 🎉' : 'Thua mất rồi :(',
                        style: TextStyle(
                          fontFamily: 'PatrickHand',
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Điểm Số: ' + data['score'].toString(),
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 30.0,
                      ),
                    ),
                    Image(
                        image: AssetImage(flag
                            ? 'assets/images/tH2hggE.png'
                            : 'assets/images/uGxjVWw.png')),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/quizpage',
                                arguments: {
                                  'data': data['data'],
                                });
                          },
                          child: Text(
                            "Chơi lại",
                            style: TextStyle(
                              fontFamily: 'PatrickHand',
                              fontSize: 30.0,
                            ),
                          ),
                          height: 60.0,
                          minWidth: 200.0,
                          color: Colors.blue[300],
                          disabledColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              fontFamily: 'PatrickHand',
                              fontSize: 30.0,
                            ),
                          ),
                          height: 60.0,
                          minWidth: 200.0,
                          color: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        flag
                            ? Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: 200,
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      controller: mycontroller,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          hintText: 'Nhập tên để lưu điểm'),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MaterialButton(
                                      onPressed: isDisable
                                          ? null
                                          : () {
                                              if (mycontroller.text.isEmpty)
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: Text(
                                                              'Bạn phải nhập tên để lưu điểm'),
                                                          actions: [
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text('OK')),
                                                          ]);
                                                    });
                                              else {
                                                saveScore();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: Text(
                                                              'Điểm đã được lưu'),
                                                          actions: [
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text('OK')),
                                                          ]);
                                                    });
                                                setState(() {
                                                  isDisable = true;
                                                });
                                              }
                                            },
                                      child: Text(
                                        "Lưu điểm",
                                        style: TextStyle(
                                          fontFamily: 'PatrickHand',
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      height: 60.0,
                                      minWidth: 200.0,
                                      color: Colors.blue[300],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
