import 'package:flutter/material.dart';

class OfficePage extends StatefulWidget {
  OfficePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  var isSelectLits = List.filled(14, false);
  var listofSelect = [
    '월세',
    '전세',
    '매매',
    '원룸',
    '투룸+',
    '조건1',
    '조건2',
    '조건3',
    '조건4',
    '조건5',
    '조건6',
    '조건7',
    '조건8'
  ];
  var backColor = Colors.lightBlue[50];
  var pontColor = Colors.black;
  RangeValues priceRange = const RangeValues(0, 100);
  RangeValues depositRange = const RangeValues(0, 10000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _printMenu("오피스텔"),
        elevation: 0.0,
        /*leading: IconButton(
            icon: Image.asset('assets/images/RoomGo.png'),
            tooltip: '메뉴',
            onPressed: () {
              _clickMe();
            }),*/
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person),
              tooltip: '사용자 정보',
              onPressed: () {
                _clickMe();
              })
        ],
      ),
      body: Column(children: <Widget>[
        _printMenu("거래 유형"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*ElevatedButton(
                child: Text('월세', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  setState(() {
                    backColor = (backColor == Colors.lightBlue[50])
                        ? Colors.lightBlue
                        : Colors.lightBlue[50];
                    pontColor = (backColor == Colors.lightBlue[50])
                        ? Colors.black
                        : Colors.white;
                  });
                },
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.lightBlue[50];
                  else
                    return Colors.lightBlue;
                }))),
*/
            _selectMenu(0),
            _selectMenu(1),
            _selectMenu(2),
          ],
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("매물 유형"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(3),
            _selectMenu(4),
          ],
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("월세"),
        RangeSlider(
          values: priceRange,
          onChanged: (RangeValues values) {
            setState(() {
              priceRange = values;
            });
          },
          activeColor: Colors.yellow[600],
          inactiveColor: Colors.yellow[200],
          labels: RangeLabels(
            priceRange.start.round().toString(),
            priceRange.end.round().toString(),
          ),
          min: 0,
          max: 100,
          divisions: 10,
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("보증금"),
        RangeSlider(
          values: depositRange,
          onChanged: (RangeValues values) {
            setState(() {
              depositRange = values;
            });
          },
          activeColor: Colors.yellow[600],
          inactiveColor: Colors.yellow[200],
          labels: RangeLabels(
            depositRange.start.round().toString(),
            depositRange.end.round().toString(),
          ),
          min: 0,
          max: 10000,
          divisions: 10,
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("세부 조건"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(5),
            _selectMenu(6),
            _selectMenu(7),
            _selectMenu(8),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(9),
            _selectMenu(10),
            _selectMenu(11),
            _selectMenu(12),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _clickMe();
        },
        tooltip: '선택된 내용으로 검색을 시작합니다.',
        backgroundColor: Colors.yellow[600],
        label: Text('선택한 조건으로 검색',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
                fontSize: 15)),
        icon: Icon(Icons.search),
        foregroundColor: Colors.brown[800],
      ),
    );
  }

  Widget _selectMenu(var n) {
    if (isSelectLits[n]) {
      return (ElevatedButton(
          child: Text(listofSelect[n], style: TextStyle(fontSize: 24)),
          onPressed: () {
            setState(() {
              isSelectLits[n] = !isSelectLits[n];
            });
          },
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.brown[800]),
              backgroundColor: MaterialStateProperty.all(Colors.yellow[600]))));
    } else {
      return (OutlinedButton(
          child: Text(listofSelect[n], style: TextStyle(fontSize: 24)),
          onPressed: () {
            setState(() {
              isSelectLits[n] = !isSelectLits[n];
            });
          },
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.brown[800]))));
    }
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
