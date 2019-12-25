import 'dart:async';
import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:dochere_client/util/google_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapViewTab extends StatefulWidget {
  @override
  _MapViewTabState createState() => _MapViewTabState();
}

class _MapViewTabState extends State<MapViewTab> {

  String GAPI = "AIzaSyCXuyYr-XqPtazHh1flN-1Gp00tO0V7MwI";
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _kCurrentLocation = CameraPosition(
    target: LatLng(6.047242, 80.214869),
    zoom: 14.4746,
  );
  // static CameraPosition _kCurrentLocation =
  //     CameraPosition(target: LatLng(0, 0));

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  SocketIO socket;
  BitmapDescriptor docIcon;

  @override
  void initState() {
    super.initState();
    initSocket();
    getAllDoctors();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(54, 54)), "images/docloc.png")
        .then((onValue) {
      docIcon = onValue;
    });
  }

  initSocket() async {
    socket = await SocketIOManager()
        .createInstance(SocketOptions('http://192.168.8.100:5000/'));
    socket.onConnect((data) {
      print("connected...");
    });

    socket.on("doc_loc_change", (data) {
      print("DOC CHANGED");
      getAllDoctors();
    });

    socket.connect();

    /////////////////////////////////////

    GoogleAPI googleapi =
        GoogleAPI(origin: LatLng(5.6, 6.6), destination: LatLng(5.33, 6.99));
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

    ///////////////////////////////////////////
  }

  getAllDoctors() async {
    final GoogleMapController controller = await _mapController.future;

    var url = "http://192.168.8.100:5000/doc_loc";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);

      setState(() {
        double latAvg = 0.0;
        double lngAvg = 0.0;
        List<dynamic> list = json.decode(response.body);
        markers.clear();
        for (int i = 0; i < list.length; i++) {
          String id = "doc_${list[i]['doctor_ID']}";
          markers[MarkerId(id)] = Marker(
              markerId: MarkerId(id),
              position: LatLng(list[i]['latitude'], list[i]['longitude']),
              icon: docIcon,
              infoWindow: InfoWindow(title: id));
          latAvg += list[i]['latitude'];
          lngAvg += list[i]['longitude'];
        }
        latAvg /= list.length;
        lngAvg /= list.length;

        final CameraPosition _docTest =
            CameraPosition(target: LatLng(latAvg, lngAvg), zoom: 10.0);
        controller.animateCamera(CameraUpdate.newCameraPosition(_docTest));
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
