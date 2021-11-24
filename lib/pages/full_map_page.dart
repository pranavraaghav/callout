import 'dart:collection';

import 'package:callout/models/post.dart';
import 'package:callout/services/database.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:callout/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class FullMap extends StatefulWidget {
  Position currentPosition;

  FullMap({this.currentPosition});
  @override
  _FullMapState createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  GoogleMapController _mapController;

  //Co-ords for India

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Set<Marker> _markers = HashSet<Marker>();
  List<Marker> _customMarkers = [];

  _placeNewMarker(LatLng tappedCoords) {
    setState(() {
      _customMarkers.add(Marker(
        markerId: MarkerId(tappedCoords.toString()),
        position: tappedCoords,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final posts = Provider.of<List<Post>>(context);
    // posts.map((post) {
    //   _placeNewMarker(LatLng(post.location.latitude, post.location.longitude));
    // });

    print("In full map:");
    print(widget.currentPosition);
    final LatLng _center = LatLng(
        widget.currentPosition.latitude, widget.currentPosition.longitude);
    return StreamProvider<List<Post>>.value(
        initialData: [],
        value: DatabaseService().posts,
        builder: (context, snapshot) {
          final posts = Provider.of<List<Post>>(context);
          posts.forEach((post) {
            _customMarkers.add(new Marker(
                markerId: MarkerId(post.title),
                position:
                    LatLng(post.location.latitude, post.location.longitude),
                infoWindow:
                    InfoWindow(title: post.title, snippet: post.authorName)));
          });
          // posts.map((post) {
          //   setState(() {
          //     _customMarkers.add(new Marker(
          //         markerId: MarkerId(post.title),
          //         position:
          //             LatLng(post.location.latitude, post.location.longitude)));
          //   });
          // });
          // _customMarkers.add(new Marker(
          //     markerId: MarkerId('Tr'), position: LatLng(20.59, 78.96)));
          return Scaffold(
            appBar: AppBar(
              title: Text('Map View'),
            ),
            bottomNavigationBar: BottomNavBar(),
            body: Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                //Set target:_center, temporary in Wadgaon
                initialCameraPosition: CameraPosition(
                    target: LatLng(20.593580, 78.963264), zoom: 12),
                markers: Set.from(_customMarkers),
                //onTap: _placeNewMarker,
              ),
            ]),
          );
        });
  }
}
