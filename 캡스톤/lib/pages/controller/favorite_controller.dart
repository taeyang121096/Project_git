import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String uid = FirebaseAuth.instance.currentUser.uid;
void favoriteData(
  String building,
  String type,
  String city,
  String gu,
  String dong,
  String docId,
) async {
  FirebaseFirestore favoriteData = FirebaseFirestore.instance;

  favoriteData.collection('favoritet').doc('').collection(uid).add(
      {'매물': building, '타입': type, '시': city, '구': gu, '동': dong, 'id': docId});
  print('add complete');
}

class ReadFavoite {
  static Future readData() async {
    FirebaseFirestore readData = FirebaseFirestore.instance;
    await readData
        .collection('favoite')
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) async {
      if (ds.exists) {
        await readData
            .collection(ds['building'])
            .doc(ds['type'])
            .collection(ds["city"])
            .doc(ds["gu"])
            .collection(ds["dong"])
            .doc(ds["docId"])
            .get()
            .then((value) {
          if (value.exists)
            return value;
          else
            return Text('No data anymore');
        });
      } else
        return Text('저장된 즐겨찾기가 없습니다.');
    });
  }
}
