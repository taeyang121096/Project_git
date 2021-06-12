import 'package:flutter/material.dart';
import 'villa.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _printMenu("Test"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person),
              tooltip: '사용자 정보',
              onPressed: () {
                _clickMe();
              })
        ],
      ),
      body: Column(children: <Widget>[_printMenu("Test"), Container()]),
    );
  }

  Widget _printMenu(var n) {
    return (Container(
      child: (Text(n,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    ));
  }
}

void _clickMe() {
  print('clicked!');
}
