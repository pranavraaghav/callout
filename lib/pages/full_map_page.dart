import 'dart:collection';

import 'package:callout/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:callout/widgets/bottom_nav_bar.dart';

class FullMap extends StatefulWidget {
  // final double initialLatitude;
  // final double initialLongitude;

  // FullMap({this.initialLatitude, this.initialLongitude});

  @override
  _FullMapState createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  GoogleMapController _mapController;

  //Co-ords for India
  static const LatLng _center = const LatLng(20.5937, 78.9629);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Set<Marker> _markers = HashSet<Marker>();
  List<Marker> _customMarkers = [];

  _placeNewMarker(LatLng tappedCoords) {
    setState(() {
      _customMarkers = [];
      _customMarkers.add(Marker(
          markerId: MarkerId(tappedCoords.toString()), position: tappedCoords));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(37.77483, -122.41942), zoom: 12),
          markers: Set.from(_customMarkers),
          onTap: _placeNewMarker,
        ),
      ]),
    );
  }
}
