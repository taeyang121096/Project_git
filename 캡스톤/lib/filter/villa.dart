import 'package:flutter/material.dart';
import 'package:honeyroom/map/map_screen.dart';
import 'testPage.dart';
import 'package:flutter/cupertino.dart';

class VillaPage extends StatefulWidget {
  VillaPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _VillaPageState createState() => _VillaPageState();
}

class _VillaPageState extends State<VillaPage> {
  @override
  var isSelectLits = List.filled(50, false);
  var listofSelect = [
    '월세',
    '전세',
    '매매',
    '원룸',
    '투룸+',
    '주차가능',
    '반려견',
    '엘레베이터',
    'CCTV',
    '현관보안',
    '경비원',
    '인터폰',
    '에어컨',
    '냉장고',
    '침대',
    '옷장',
    '신발장',
    '세탁기',
    '건조기',
    '식기세척기',
    '전자레인지',
    '복층',
    '~ 10평',
    '10평대',
    '20평대',
    '30평대',
    '40평대',
    '50평대',
    '60평대',
    '70평 ~',
    '지하',
    '저층',
    '중간충',
    '고층',
    '1개',
    '2개',
    '3개',
    '4개이상',
    '1개',
    '2개',
    '3개',
    '4개이상',
    '~ 5년',
    '~ 10년',
    '~ 15년',
    '15년 ~',
  ];

  var backColor = Colors.lightBlue[50];
  var pontColor = Colors.black;
  RangeValues priceRange = const RangeValues(0, 100);
  RangeValues depositRange = const RangeValues(0, 10000);
  @override
  Widget build(BuildContext context) {
    for (var i in listofSelect) {}
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _printMenu("필터"),
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
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        _printMenu("거래 유형"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
        _printMenu("면적"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(22),
            _selectMenu(23),
            _selectMenu(24),
            _selectMenu(25),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(26),
            _selectMenu(27),
            _selectMenu(28),
            _selectMenu(29),
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
          activeColor: Colors.brown[600],
          inactiveColor: Colors.brown[200],
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
          activeColor: Colors.brown[600],
          inactiveColor: Colors.brown[200],
          labels: RangeLabels(
            depositRange.start.round().toString(),
            depositRange.end.round().toString(),
          ),
          min: 0,
          max: 10000,
          divisions: 10,
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        Container(
            child: Column(
          children: <Widget>[
            _printMenu("층수"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectMenu(30),
                _selectMenu(31),
                _selectMenu(32),
                _selectMenu(33),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            _printMenu("방개수"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectMenu(34),
                _selectMenu(35),
                _selectMenu(36),
                _selectMenu(37),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            _printMenu("화장실"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectMenu(38),
                _selectMenu(39),
                _selectMenu(40),
                _selectMenu(41),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            _printMenu("건축년도"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectMenu(42),
                _selectMenu(43),
                _selectMenu(44),
                _selectMenu(45),
              ],
            ),
          ],
        )),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("편의 시설"),
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
          children: <Widget>[_selectMenu(9), _selectMenu(10), _selectMenu(11)],
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        _printMenu("세부 옵션"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(12),
            _selectMenu(13),
            _selectMenu(14),
            _selectMenu(15),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectMenu(16),
            _selectMenu(17),
            _selectMenu(18),
            _selectMenu(19),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_selectMenu(20), _selectMenu(21)],
        ),
        Padding(padding: EdgeInsets.all(50.0)),
      ])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Main()));
        },
        tooltip: '선택된 내용으로 검색을 시작합니다.',
        backgroundColor: Colors.brown[600],
        label: Text('선택한 조건으로 검색',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow[600],
                fontSize: 15)),
        icon: Icon(Icons.search),
        foregroundColor: Colors.yellow[600],
      ),
    );
  }

  Widget _selectMenu(var n) {
    if (isSelectLits[n]) {
      return (ElevatedButton(
          child: Text(listofSelect[n], style: TextStyle(fontSize: 13)),
          onPressed: () {
            setState(() {
              isSelectLits[n] = !isSelectLits[n];
            });
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(92, 35)),
              foregroundColor: MaterialStateProperty.all(Colors.yellow[600]),
              backgroundColor: MaterialStateProperty.all(Colors.brown[600]))));
    } else {
      return (OutlinedButton(
          child: Text(listofSelect[n], style: TextStyle(fontSize: 13)),
          onPressed: () {
            setState(() {
              isSelectLits[n] = !isSelectLits[n];
            });
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(85, 35)),
              foregroundColor: MaterialStateProperty.all(Colors.black))));
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
