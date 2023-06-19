
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';

class DetailCourierProvider extends ChangeNotifier {

  int? id;
  List<DataPesakit>? listPesakit;
  bool isLoading = true;
  List<LatLng> routeCoords = [];

  DetailCourierProvider(this.id) {
    listDataPesakit(id);
  }

  Future<void> listDataPesakit(id) async {
    final response = await NetworkProvider().getDataPesakit(id);
    listPesakit = response?.data ?? [];
    notifyListeners();
  }

  void logoutAuth(BuildContext context) async {
    final response = await http.delete(Uri.parse(ApiConfig.url + "api/logout"),
        headers: <String, String>{
          'Authorization': 'Bearer ${dataGlobal.data?.token}'
        });

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (contex) => SplashScreenPageView()),
              (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Logout Failed!",
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  Future<void> getRoute(origin, destination) async {
    final url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${origin
        .longitude},${origin.latitude};${destination.longitude},${destination
        .latitude}?alternatives=true&exclude=toll&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoiZHppa3J1bDE2MTYiLCJhIjoiY2xleWJ6aTdlMGc0ODQxcXZsaDZlaDhwciJ9.Nz95V3UL1b8AfExigWUllA";

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