import 'package:flutter/material.dart';
import 'package:honeyroom/filter/villa.dart';

class Distance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Row(
          children: [
            Text(
              '거리기반탐색',
              style: TextStyle(
                  color: Colors.yellow, fontFamily: 'OpenSans', fontSize: 25),
            ),
          ],
        ),
      ),
      body: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          title: Center(child: Text('15분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('20분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('25분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('30분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('35분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('40분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('45분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('50분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('55분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
        ListTile(
          title: Center(child: Text('60분')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (VillaPage())),
            );
          },
        ),
        Divider(),
      ]),
    );
  }
}
