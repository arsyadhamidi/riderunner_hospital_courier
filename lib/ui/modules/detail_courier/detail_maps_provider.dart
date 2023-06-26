
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DetailMapsProvider extends ChangeNotifier{

  List<LatLng> routeCoords = [];

  Future<void> getRoute(origin, destination) async {
    final url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${origin
        .longitude},${origin.latitude};${destination.longitude},${destination
        .latitude}?alternatives=true&exclude=toll&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    final route = data['routes'][0]['geometry']['coordinates'];
    routeCoords = route
        .map((point) => LatLng(point[1], point[0]))
        .toList()
        .cast<LatLng>();
    notifyListeners();
  }

}