import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

final String baseUrl =
    'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';
const String API_KEY = 'AIzaSyBjJS0R3g8LUziS9ucwWHmgQr4wXJvIXio';

Future<List> pointSearch(String address, String number) async {
  List points = [];
  var _places = address + number; //동,지번 넣으면됨
  final String url =
      '$baseUrl?key=$API_KEY&input=$_places&fields=geometry&inputtype=textquery';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['status'] == 'OK') {
      final foundPlaces = data['candidates'];
      points.add(foundPlaces[0]['geometry']['location']['lat']);
      points.add(foundPlaces[0]['geometry']['location']['lng']);
      return points;
    } else
      print('No location data');
  } else
    print('Fail to fetch place data');
}
