import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Algorithm {
  static final String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String API_KEY = 'AIzaSyBjJS0R3g8LUziS9ucwWHmgQr4wXJvIXio';
  static var _lat;
  static var _lng;
  static String _destination;
  static int startTime;
  static var type;
  static int _time;
//type=walking,bicycling,driving,transit

  static algorithm(
      LatLng latLng, int time, QuerySnapshot snapshot, String type) async {
    _lat = latLng.latitude;
    _lng = latLng.longitude;
    List state;
    List city;

    _time = time;
    String jsonString = await rootBundle.loadString('json/4depth.json');
    Map _item = json.decode(jsonString);
    _item.forEach((key1, values1) {
      _item[search(key1)].forEach((key2, values2) {
        _item[key2][search(values2)].forEach((key3, values3) {
          _item[key2][key3][search(values3)].forEach((element) {
            city.add(key2);
            city.add(key3);
            city.add(search(element));
            state.add(city);
            city.clear();
          });
        });
      });
    });
    return state;
  }

  static search(element) async {
    _destination = element;
    final String url =
        '$baseUrl?key=$API_KEY&origin=$_lat,$_lng&destination=$_destination&departure_time=$startTime&mode=$type';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final direction = data['results'];
        var duration = direction['route']['duration']['value'];
        if (duration <= _time) {
          return element;
        }
      } else
        print('No location data');
    } else
      print('Fail to fetch place data');
  }
}
