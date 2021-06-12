import 'package:honeyroom/map/map/map_important_location.dart';
import 'package:honeyroom/map/map_support/picked_locations_provider.dart';
import 'package:honeyroom/map/map_support/google_map_service.dart';
import 'package:honeyroom/map/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:honeyroom/map/map_support/picked_location.dart';
import 'package:provider/provider.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  PickedLocation pickedLocation;
  String mapImageUrl;
  bool mapLoading = false;
  Map<String, dynamic> pickedLoc;
  TextEditingController _addressController = TextEditingController();

  void _submit() {
    if (!_fbKey.currentState.validate() || pickedLoc['address'] == null) {
      return;
    }

    _fbKey.currentState.save();
    final inputValues = _fbKey.currentState.value;
    print(inputValues);

    final PickedLocation newLocation = PickedLocation(
      comment: inputValues['comment'],
      address: inputValues['address'],
      lat: pickedLoc['latitude'],
      lng: pickedLoc['longitude'],
    );

    Provider.of<PickedLocationsProvider>(context, listen: false)
        .addLocation(newLocation);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ImportantLocations(),
      ),
    );
  }

  _pickLocation() async {
    pickedLoc = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Total(),
        fullscreenDialog: true,
      ),
    );

    print(pickedLoc);

    if (pickedLoc == null) {
      return;
    }

    setState(() => mapLoading = true);

    final staticImageUrl = GoogleMapServices.getStaticMap(
        pickedLoc['latitude'], pickedLoc['longitude']);

    setState(() {
      _addressController.text = pickedLoc['address'];
      mapImageUrl = staticImageUrl;
      mapLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('찜할 집을 찾으시오',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.deepOrange)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    '찜할 집을 선택하세요',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: FormBuilderTextField(
                      name: 'comment',
                      decoration: InputDecoration(
                        labelText: '이름',
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: FormBuilderTextField(
                      controller: _addressController,
                      name: 'address',
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '주소',
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey[100],
              ),
              child: mapImageUrl == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                            iconSize: 96,
                            onPressed: _pickLocation,
                          ),
                          Text(
                            '장소를 선택하려면 + 아이콘을 탭하세요',
                          ),
                        ],
                      ),
                    )
                  : mapLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Image.network(mapImageUrl,
                          width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              textColor: Colors.white,
              height: 45.0,
              minWidth: 180,
              color: Colors.deepOrange,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.check,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '찜',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
