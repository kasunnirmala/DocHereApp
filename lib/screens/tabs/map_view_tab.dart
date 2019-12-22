import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewTab extends StatefulWidget {
  @override
  _MapViewTabState createState() => _MapViewTabState();
}

class _MapViewTabState extends State<MapViewTab> {
  Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.047242, 80.214869),
    zoom: 14.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  // final GoogleMapController controller = await _mapController.future;
  // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  Future<void> _goToTheLake() async {
    setState(() {
      markers[MarkerId("asd")] = Marker(
        markerId: MarkerId("asd"),
        position: LatLng(6.047242, 80.214869),
        infoWindow: InfoWindow()
      );
    });
  }
}
