import 'package:honeyroom/main.dart';
import 'package:honeyroom/map/map/map_view.dart';
import 'package:honeyroom/map/test.dart';
import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFecec1c),
      appBar: AppBar(
          title: Text(
            '1층, 반려동물, 등, 등',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.deepOrange),
          ),
          leading: TextButton(
            onPressed: () {},
            child: SizedBox(
              height: 40,
              width: 40,
              child: Icon(Icons.arrow_back_rounded),
            ),
          ),
          backgroundColor: const Color(0xFFecec1c),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.star),
              tooltip: 'favorite',
              onPressed: () {},
            )
          ]),
      body: Myapp(),
    );
  }
}
