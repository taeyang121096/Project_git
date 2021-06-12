import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:honeyroom/map/map/map_important_location.dart';
import 'package:honeyroom/map/map/map_pick.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:honeyroom/map/map_support/google_map_service.dart';
import 'package:honeyroom/map/map_support/place.dart';
import 'package:http/http.dart' as http;
import 'package:honeyroom/map/constants/constants.dart';
import 'package:honeyroom/map/map_support/map_marker.dart';

import 'map_cluster/map_helper.dart';
import 'map_cluster/map_marker_cluster.dart';

class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  var uuid = Uuid();
  var sessionToken;
  var googleMapServices;
  PlaceDetail placeDetail;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();

  LatLng _center;
  Position currentLocation;
  double distance = 0.0;
  String myAddr = '';

  bool loading = false;
  LatLng selectedLocation;
  String selectedAddress;

  Uint8List markerIcon;

  LatLng position;

  /// 여기 부터 클러스터링 변수들
  bool _areMarkersLoading = true;

  double _currentZoom = 15;

  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 19;
  Fluster<MapMarker> _clusterManager;
  final Color _clusterColor = Colors.brown;
  final Color _clusterTextColor = Colors.deepOrange;

  /// 여기가 클러스터링 부분 함
  Future<void> _updateMarkers([double updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == _currentZoom) return;

    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }

    setState(() {
      _areMarkersLoading = true;
    });

    final updatedMarkers = await MapHelper.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      _clusterColor,
      _clusterTextColor,
      80,
    );

    _markers
      ..clear()
      ..addAll(updatedMarkers);

    setState(() {
      _areMarkersLoading = false;
    });
  }

  ///수 여기 까지

  final tcontroller = TextEditingController();
  Widget appBarTitle = new Text("map");
  Icon actionIcon = new Icon(Icons.search);

  /// 사용자 위치 가져오기
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// 사용자 위치 표시 하기
  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    myAddr = await GoogleMapServices.getAddrFromLocation(
        currentLocation.latitude, currentLocation.longitude);
    _setMyLocation(currentLocation.latitude, currentLocation.longitude, myAddr);
  }

  /// 이게 저기 네모 박스 마커 만드는건데 이거 말고 클러스터링 하는 부분처럼 바꿀까 하는 부분
  void setCustomMarker(addr) async {
    markerIcon = await getBytesFromCanvas(300, 100, addr);
  }

  /// 마커 처음 찍어주는 부분
  void _setMyLocation(latitude, longtitude, Addr) {
    var _latitude = latitude;
    var _longtitude = longtitude;

    setState(() async {
      _markers.add(Marker(
        markerId: MarkerId('myInitialPostion'),
        position: LatLng(_latitude, _longtitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {},
        infoWindow: InfoWindow(
          title: '나의 위치',
          snippet: Addr,
        ),
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker('내 위치');
    getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  /// 내가 위치 터치하면 옮겨 지는 부분
  _selectLocation(LatLng loc) async {
    setState(() {
      loading = true;
      _setMyLocation(loc.latitude, loc.longitude, selectedAddress);
    });
    selectedAddress = await GoogleMapServices.getAddrFromLocation(
        loc.latitude, loc.longitude);
    setState(() {
      loading = false;
      selectedLocation = loc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.brown,
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
                  child: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              backgroundColor: Colors.brown,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                  ),
                  tooltip: 'favorite',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImportantLocations()));
                  },
                )
              ]),
          body: Stack(
            children: <Widget>[
              _center == null
                  ? Center(child: CircularProgressIndicator())
                  : ModalProgressHUD(
                      inAsyncCall: loading,
                      child: GoogleMap(
                        onTap: _selectLocation,
                        initialCameraPosition:
                            CameraPosition(target: _center, zoom: _currentZoom),
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: _markers,
                        onCameraMove: (position) =>
                            _updateMarkers(position.zoom),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 60, right: 10),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      onPressed: () {
                        stateStterSearch();
                      },
                      label: Text(
                        '현 위치 아파트',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.yellow),
                      ),
                      elevation: 8,
                      icon: Icon(
                        Icons.gps_fixed_outlined,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      backgroundColor: Colors.brown,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        stateStterPointSearch();
                      },
                      label: Text('주변 아파트',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.yellow)),
                      elevation: 8,
                      icon: Icon(
                        Icons.map,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      backgroundColor: Colors.brown,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  /// 현재 위치 기반 아파트 찾기
  void stateStterSearch() {
    setState(() {
      _search(currentLocation.latitude, currentLocation.longitude);
    });
  }

  /// 옮기 기반 위치 아파트 찾기
  void stateStterPointSearch() {
    setState(() {
      _pointSearch(selectedLocation.latitude, selectedLocation.longitude);
    });
  }

  /// 검색 통해서 나온 아파트들 마커 찍어주는 부분인데 여기가 아마 아이콘이 업데이트 안되는거 같어 변수는 잘들어가
  void _search(dynamic latitude, dynamic longtitude) async {
    setState(() {
      _markers.clear();
      getUserLocation();
      loading = true;
    });

    var _latitude = latitude;
    var _longtitude = longtitude;
    var _places = '아파트';
    final String url =
        '$baseUrl?key=$API_KEY&location=$_latitude,$_longtitude&keyword=$_places&radius=500&language=ko';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(_center, 16));

        setState(() {
          final foundPlaces = data['results'];

          for (int i = 0; i < foundPlaces.length; i++) {
            setCustomMarker(foundPlaces[i]['name']);
            _markers.add(
              Marker(
                  markerId: MarkerId(foundPlaces[i]['place_id']),
                  position: LatLng(
                    foundPlaces[i]['geometry']['location']['lat'],
                    foundPlaces[i]['geometry']['location']['lng'],
                  ),
                  icon: BitmapDescriptor.fromBytes(markerIcon),
                  infoWindow: InfoWindow(
                    title: foundPlaces[i]['name'],
                    snippet: foundPlaces[i]['vicinity'],
                  ),
                  onTap: () {}),
            );
          }

          loading = false;
        });
      }
    } else {
      print('Fail to fetch place data');
    }
  }

  /// 위랑 똑같음
  void _pointSearch(dynamic latitude, dynamic longtitude) async {
    var _latitude = latitude;
    var _longtitude = longtitude;
    var _places = '아파트';
    setState(() {
      loading = true;
      _markers.clear();
      _setMyLocation(_latitude, _longtitude, selectedAddress);
    });
    final String url =
        '$baseUrl?key=$API_KEY&location=$_latitude,$_longtitude&keyword=$_places&radius=500&language=ko';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        setState(() {
          final foundPlaces = data['results'];

          for (int i = 0; i < foundPlaces.length; i++) {
            setCustomMarker(foundPlaces[i]['name']);
            _markers.add(
              Marker(
                  markerId: MarkerId(foundPlaces[i]['place_id']),
                  position: LatLng(
                    foundPlaces[i]['geometry']['location']['lat'],
                    foundPlaces[i]['geometry']['location']['lng'],
                  ),
                  icon: BitmapDescriptor.fromBytes(markerIcon),
                  infoWindow: InfoWindow(
                    title: foundPlaces[i]['name'],
                    snippet: foundPlaces[i]['vicinity'],
                  ),
                  onTap: () {}),
            );
          }
          loading = false;
        });
      }
    } else {
      print('Fail to fetch place data');
    }
  }
}
