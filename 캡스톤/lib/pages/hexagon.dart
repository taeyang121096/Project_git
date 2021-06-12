import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexagon/hexagon.dart';
import 'package:honeyroom/login/login_screen.dart';
import 'package:honeyroom/map/map_screen.dart';
import 'package:honeyroom/pages/screen/favorite_screen.dart';
import 'package:honeyroom/pages/screen/menu1.dart';
import 'package:honeyroom/pages/screen/menu2.dart';
import 'package:honeyroom/pages/screen/menu3.dart';
import 'package:honeyroom/pages/screen/menu4.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  HexagonType type = HexagonType.POINTY;
  FirebaseAuth auth = FirebaseAuth.instance;
  var _loggedin = false;
  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      _loggedin = true;
    } else
      _loggedin = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Row(
            children: [
              SizedBox(
                child: Image.asset('assets/images/RoomGowithB.png'),
                width: 40,
                height: 40,
              ),
              Text(
                '꿀방',
                style: TextStyle(
                    color: Colors.yellow, fontFamily: 'OpenSans', fontSize: 25),
              ),
            ],
          ),
          // leading: TextButton(
          //   onPressed: () {},
          //   child: SizedBox(
          //     height: 40,
          //     width: 40,
          //     child: Image.asset('assets/images/RoomGowithB.png'),
          //   ),
          // ),
          actions: <Widget>[]),
      endDrawer: Drawer(
          child: Container(
        color: Colors.yellow[50],
        child: Stack(
          children: [
            Container(
              height: 420,
              child: Image.asset('assets/images/honey.jpg'),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                _login(),
                ListTile(
                  title: Text('즐겨찾기'),
                  leading: Icon(
                    Icons.star,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Favorite()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('로그아웃'),
                  leading: Icon(
                    Icons.logout,
                    size: 40,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    setState() {
                      _loggedin = false;
                    }

                    Navigator.pop(context);
                  },
                ),
                Divider(),
                new AboutListTile(
                  icon: new Icon(
                    Icons.miscellaneous_services,
                    size: 40,
                  ),
                  child: new Text("버전정보"),
                  applicationName: "꿀방",
                  applicationVersion: "1.0.0",
                  applicationIcon: new Image.asset(
                    'assets/images/RoomGowithB.png',
                    width: 55.0,
                    height: 55.0,
                  ),
                  applicationLegalese: "June 2021",
                  aboutBoxChildren: <Widget>[
                    new Text(
                      "Team Leader",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    new Text(
                      "이충현",
                      style: TextStyle(color: Colors.black),
                    ),
                    new Text(
                      "Team members",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    new Text("김현수", style: TextStyle(color: Colors.black)),
                    new Text("이태양", style: TextStyle(color: Colors.black)),
                    new Text("이현구", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
      body: Stack(
        children: [
          Positioned.fill(
              child: AnimatedContainer(
            child: _buildVerticalGrid(),
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          )),
        ],
      ),
    );
  }

  Widget _login() {
    return _loggedin
        ? UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset(
              'assets/images/RoomGowithB.png',
            ),
            accountEmail: Text(
              FirebaseAuth.instance.currentUser.email,
              style: TextStyle(backgroundColor: Colors.yellow[40]),
            ),
            accountName: null,
            decoration: BoxDecoration(
              color: Colors.brown,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/hive.jpg')),
            ),
          )
        : UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset(
              'assets/images/RoomGowithB.png',
            ),
            accountEmail: RaisedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              ),
              child: Text('로그인'),
              color: Colors.yellow,
            ),
            accountName: null,
            decoration: BoxDecoration(
              color: Colors.brown,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/hive.jpg')),
            ),
          );
  }

  Widget _buildVerticalGrid() {
    var center = Center(
      child: HexagonOffsetGrid.oddPointy(
        color: Colors.brown[400],
        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
        columns: 4,
        rows: 4,
        buildTile: (col, row) => HexagonWidgetBuilder(
          color: row.isEven ? Colors.yellow : Colors.orangeAccent,
          elevation: 6.0,
          padding: 5.0,
        ),
        buildChild: (col, row) => hexagonWidgetBuilder(col, row),
      ),
    );
    return FittedBox(
        fit: BoxFit.fitHeight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 300,
            maxWidth: 800,
            minHeight: 300,
            maxHeight: 700,
          ),
          child: center,
        ));
  }

  Widget hexagonWidgetBuilder(int col, int row) {
    if (col == 2 && row == 0) {
      return InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Distance(),
                ),
              ),
          child: setIcons(col, row));
    } else if (col == 1 && row == 1) {
      return InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              ),
          child: setIcons(col, row));
    } else if (col == 2 && row == 2) {
      return InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              ),
          child: setIcons(col, row));
    } else if (col == 1 && row == 3) {
      return InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              ),
          child: setIcons(col, row));
    }
  }

  setText(int col, int row) {
    if (col == 2 && row == 0) {
      return "거리기반 탐색";
    } else if (col == 1 && row == 1) {
      return "아파트";
    } else if (col == 2 && row == 2) {
      return "빌라";
    } else if (col == 1 && row == 3) {
      return "오피스텔";
    } else
      return "";
  }

  Widget setIcons(int col, int row) {
    if (col == 2 && row == 0) {
      return Column(children: [
        Padding(padding: EdgeInsets.all(30.0)),
        SizedBox(
          child: Icon(
            Icons.pin_drop,
            size: 60,
          ),
        ),
        Text(setText(col, row)),
      ]);
    } else if (col == 1 && row == 1) {
      return Column(children: [
        Padding(padding: EdgeInsets.all(30.0)),
        SizedBox(
          child: Icon(
            Icons.domain_rounded,
            size: 60,
          ),
        ),
        Text(setText(col, row)),
      ]);
    } else if (col == 2 && row == 2) {
      return Column(children: [
        Padding(padding: EdgeInsets.all(30.0)),
        SizedBox(
          child: Icon(
            Icons.home_rounded,
            size: 60,
          ),
        ),
        Text(setText(col, row)),
      ]);
    } else if (col == 1 && row == 3) {
      return Column(children: [
        Padding(padding: EdgeInsets.all(30.0)),
        SizedBox(
          child: Icon(
            Icons.home_work_rounded,
            size: 60,
          ),
        ),
        Text(setText(col, row)),
      ]);
    } else
      return Column(children: [
        Padding(padding: EdgeInsets.all(30.0)),
        SizedBox(
          child: Icon(
            null,
          ),
        ),
        Text(setText(col, row)),
      ]);
  }
  //
  // Color setColor(int col, int row) {
  //   if(col ==2 &&row ==0){
  //
  //   }
  //   else if(col ==2 &&row ==0){
  //
  //   }
  //   else if(col ==1 &&row ==1){
  //
  //   }
  //   else if(col ==1 &&row ==1){
  //
  //   }
  //   else
  //     ,  }
}
