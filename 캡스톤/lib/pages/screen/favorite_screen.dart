import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:honeyroom/pages/controller/favorite_controller.dart';

String uid = FirebaseAuth.instance.currentUser.uid;

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          '즐겨찾기',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: buildFavoite(),
      backgroundColor: Colors.yellow[50],
    );
  }
}

Widget buildFavoite() {
  favoriteData('building', 'type', 'city', 'gu', 'dong', 'docId');
  // return ListView(
  //   children: [
  //     for (int i = 0; i < 10; i++) {ListTile(), Divider()}
  //   ],
  // );
  //favoriteData('building', 'type', 'city', 'gu', 'dong', 'docId');

  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('favoritet')
          .doc()
          .collection(uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        print(snapshot.data.docs.toString());
        return ListView(
          children: snapshot.data.docs.map((document) {
            return Container(
              child: Column(children: [Text(document['동'])]),
            );
          }).toList(),
        );
      });
}
