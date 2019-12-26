import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleAPI {
  LatLng origin;
  LatLng destination;
  GoogleAPI({@required this.origin, @required this.destination});
  String googleAPI = "AIzaSyCXuyYr-XqPtazHh1flN-1Gp00tO0V7MwI";

  Future<Map<String, dynamic>> getLocationJSON() async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleAPI";
    Map<String, dynamic> mapData = Map();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      dynamic body = json.decode(response.body);
      mapData = {
        "distance": body['routes'][0]['legs'][0]['distance']['text'],
        "duration": body['routes'][0]['legs'][0]['duration']['text'],
        "pointString": body['routes'][0]['overview_polyline']['points'],
      };
    }
    return mapData;
  }



  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  
}
