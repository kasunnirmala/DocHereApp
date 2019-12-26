import 'dart:async';
import 'dart:convert';

import 'package:dochere_client/util/app_data.dart';
import 'package:dochere_client/util/google_api.dart';
import 'package:dochere_client/util/socket_singleton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapViewTab extends StatefulWidget {
  MapViewTab();
  @override
  _MapViewTabState createState() => _MapViewTabState();
}

class _MapViewTabState extends State<MapViewTab> {
  List<int> nearestDocIDs = List();
  setCurrentPosition() async {
    final GoogleMapController controller = await _mapController.future;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final CameraPosition _currLoc = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: AppData.zoomLevel);
    controller.animateCamera(CameraUpdate.newCameraPosition(_currLoc));
  }

  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _kCurrentLocation = CameraPosition(
    target: LatLng(6.047242, 80.214869),
    zoom: AppData.zoomLevel,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var s1;
  BitmapDescriptor docIcon;
  setSocket() async {
    (s1.socket).on("doc_loc_change", (data) {
      print("DOC CHANGED");
      getAllDoctors();
    });
  }

  @override
  void initState() {
    super.initState();
    setCurrentPosition();
    s1 = SocketSingleton();
    super.initState();
    setSocket();
    print(s1.socket == null);
    getAllDoctors();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(54, 54)), "images/docloc.png")
        .then((onValue) {
      docIcon = onValue;
    });
  }

  setMapRoute(LatLng origin, LatLng destination) async {
    GoogleAPI googleapi = GoogleAPI(origin: origin, destination: destination);
    dynamic mapData = await googleapi.getLocationJSON();

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: googleapi.decodeEncodedPolyline(mapData['pointString']),
        width: 3,
        onTap: () {});
    setState(() {
      _polylines[id] = polyline;
    });
  }

  makeNearestDocList(
      double lat, double lng, int docID, Position position) async {
    double distanceInMeters = await Geolocator()
        .distanceBetween(position.latitude, position.longitude, lat, lng);
    print(distanceInMeters);

    if (distanceInMeters <= 5000) {
      nearestDocIDs.add(docID);
    }
  }

  getAllDoctors() async {
    var url = "http://192.168.8.100:5000/doc_loc";

    final GoogleMapController controller = await _mapController.future;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final CameraPosition _currLoc = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: AppData.zoomLevel);
    controller.animateCamera(CameraUpdate.newCameraPosition(_currLoc));

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);

      setState(() {
        List<dynamic> list = json.decode(response.body);
        markers.clear();
        for (int i = 0; i < list.length; i++) {
          String id = "doc_${list[i]['doctor_ID']}";
          markers[MarkerId(id)] = Marker(
              markerId: MarkerId(id),
              position: LatLng(list[i]['latitude'], list[i]['longitude']),
              icon: docIcon,
              infoWindow: InfoWindow(title: id));

          makeNearestDocList(list[i]['latitude'], list[i]['longitude'],
              list[i]['doctor_ID'], position);
        }

        print(nearestDocIDs.length);
        // setMapRoute(LatLng(list[0]['latitude'], list[0]['longitude']),
        //     LatLng(6.046888, 80.214781));
      });
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kCurrentLocation,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        polylines: Set<Polyline>.of(_polylines.values),
        markers: Set<Marker>.of(markers.values),
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
      ),
    );
  }
}
