import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import 'package:honeyroom/map/constants/constants.dart';
import 'package:path/path.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _googleMapType = MapType.normal;
  int _mapType = 0;
  Set<Marker> _markers = Set();
  GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('myInitialPosition'),
      position: LatLng(37.382782, 127.1189054),
      infoWindow: InfoWindow(title: 'My Position', snippet: 'where am I?'),
    ));
  }

  CameraPosition _initialCameraPostion =
      CameraPosition(target: LatLng(37.382782, 127.1189054), zoom: 14);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _searchPlaces(
    String locationName,
    double latitude,
    double longitude,
  ) async {
    setState(() {
      _markers.clear();
    });

    final String url =
        '$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=1000&language=ko&keyword=$locationName';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude, longitude),
          ),
        );

        setState(() {
          final foundPlaces = data['results'];

          for (int i = 0; i < foundPlaces.length; i++) {
            _markers.add(
              Marker(
                markerId: MarkerId(foundPlaces[i]['id']),
                position: LatLng(
                  foundPlaces[i]['geometry']['location']['lat'],
                  foundPlaces[i]['geometry']['location']['lng'],
                ),
                infoWindow: InfoWindow(
                  title: foundPlaces[i]['name'],
                  snippet: foundPlaces[i]['vicinity'],
                ),
              ),
            );
          }
        });
      }
    } else {
      print('Fail to fetch place data');
    }
  }

  void _submit() {
    if (!_fbkey.currentState.validate()) {
      return;
    }

    _fbkey.currentState.save();
    final inputValues = _fbkey.currentState.value;
    final id = inputValues['placeId'];
    print(id);

    final foundPlace = places.firstWhere(
      (place) => place['id'] == id,
      orElse: () => null,
    );

    print(foundPlace['placeName']);

    _searchPlaces(foundPlace['placeName'], 37.498295, 127.026437);

    Navigator.of(this.context).pop();
  }

  void _gotoGangnam() {
    showModalBottomSheet(
      context: this.context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    right: 20,
                    left: 20,
                    bottom: 20,
                  ),
                  child: FormBuilder(
                    key: _fbkey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderDropdown(
                          name: 'placeId',
                          hint: Text('어떤 장소를 원하세요?'),
                          decoration: InputDecoration(
                            filled: true,
                            labelText: '장소',
                            border: OutlineInputBorder(),
                          ),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: places.map<DropdownMenuItem<String>>(
                            (place) {
                              return DropdownMenuItem<String>(
                                value: place['id'],
                                child: Text(place['placeName']),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text('Submit'),
                  onPressed: _submit,
                  color: Colors.indigo,
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _googleMapType,
            initialCameraPosition: _initialCameraPostion,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: _markers,
          ),
          Container(
            margin: EdgeInsets.only(top: 60, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  heroTag: 'btn2',
                  label: Text('강남에서 볼까?'),
                  icon: Icon(Icons.zoom_out_map),
                  elevation: 8,
                  backgroundColor: Colors.blue[400],
                  onPressed: _gotoGangnam,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
