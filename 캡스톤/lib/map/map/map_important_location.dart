import 'package:honeyroom/map/map_support/picked_location.dart';
import 'package:honeyroom/map/map/map_pick.dart';
import 'package:honeyroom/map/map_support/picked_locations_provider.dart';
import 'package:honeyroom/map/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportantLocations extends StatefulWidget {
  @override
  _ImportantLocationsState createState() => _ImportantLocationsState();
}

class _ImportantLocationsState extends State<ImportantLocations> {
  List<PickedLocation> locations = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  _getLocations() async {
    setState(() => isLoading = true);
    try {
      await Provider.of<PickedLocationsProvider>(context, listen: false)
          .getLocations();
      setState(() => isLoading = false);
    } catch (err) {
      setState(() => isLoading = false);
      print(err);
    }
  }

  _deleteLocation(PickedLocation location) async {
    setState(() => isLoading = true);
    try {
      await Provider.of<PickedLocationsProvider>(context, listen: false)
          .deleteLocation(location.id);
      setState(() => isLoading = false);
    } catch (err) {
      setState(() => isLoading = false);
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(
          'Important Locations',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellow),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.yellow,
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Total(),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.brown,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : locations.length == 0
              ? Center(
                  child: Text('Add important locations',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.yellow)))
              : ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          locations[index].address,
                        ),
                        subtitle: Text(locations[index].comment),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteLocation(locations[index]),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
