import 'package:honeyroom/map/appbar_menu/appbar.dart';
import 'package:honeyroom/map/map/map_big.dart';
import 'package:honeyroom/map/map/map_pick.dart';
import 'package:honeyroom/map/map_screen.dart';
import 'package:honeyroom/map/test.dart';
import 'package:honeyroom/map/testing.dart';
import 'package:flutter/material.dart';

import 'package:honeyroom/map/map/map_tmap.dart';
import 'package:honeyroom/map/map/map_auto.dart';
import 'package:honeyroom/map/map/map_important_location.dart';
import 'package:honeyroom/map/map/map_view.dart';
import 'package:honeyroom/map/map/map_location_auto.dart';
import 'package:honeyroom/map/map_support/picked_locations_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:honeyroom/map/map_screen.dart';
import 'package:honeyroom/openAPI/JsonParseDemo.dart';
import 'package:honeyroom/pages/hexagon.dart';

//import 'login/transition_route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JsonParseDemo(), // api, firebase
      //home: LineChartWidget(), //차트 그리기
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      //navigatorObservers: [TransitionRouteObserver()],
    );
  }
}


// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '꿀방',
//       theme: ThemeData(
//         backgroundColor: Colors.yellow[50],
//         // brightness: Brightness.dark,
//         primarySwatch: Colors.yellow,
//         accentColor: Colors.orange,
//         textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
//         // fontFamily: 'SourceSansPro',
//         iconTheme: IconThemeData(color: Colors.brown),
//         textTheme: TextTheme(
//           button: TextStyle(
//             fontFamily: 'OpenSans',
//             color: Colors.black,
//           ),
//           caption: TextStyle(
//             fontFamily: 'NotoSans',
//             fontSize: 12.0,
//             fontWeight: FontWeight.normal,
//             color: Colors.grey,
//           ),
//           headline1: TextStyle(
//             fontFamily: 'Quicksand',
//             color: Colors.black,
//           ),
//           headline2: TextStyle(
//             fontFamily: 'Quicksand',
//             color: Colors.black,
//           ),
//           headline3: TextStyle(
//             fontFamily: 'OpenSans',
//             fontSize: 45.0,
//             //fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//           headline4: TextStyle(
//             fontFamily: 'Quicksand',
//             color: Colors.black,
//           ),
//           headline5: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//           headline6: TextStyle(fontFamily: 'NotoSans', color: Colors.black),
//           bodyText1: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//           bodyText2: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//           subtitle1: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//           subtitle2: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//           overline: TextStyle(
//             fontFamily: 'NotoSans',
//             color: Colors.black,
//           ),
//         ),
//       ),
//       home: MyHomePage(),
//       //navigatorObservers: [TransitionRouteObserver()],
//     );
//   }
// }
