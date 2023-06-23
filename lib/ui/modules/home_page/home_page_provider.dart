import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/user_model.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:http/http.dart' as http;
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageProvider extends ChangeNotifier {
  HomePageProvider() {
    init();
  }

  init() {
    getDataUser();
    getGeolocationPosition();
  }

  List<DataDokter>? listDokter;
  List<DataDokter>? filterDokterList = [];
  TextEditingController isDateSearchTxt = TextEditingController();
  final MapController mapController = MapController();
  String currentAddress = 'Your Location';
  bool isLoading = true;

  Future<void> getDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = prefs.getString('dataUser');
    print(jsonDecode(login ?? ""));
    dataGlobal.data = modelUserFromJson(login ?? "");

    listDataDokter();
  }

  Future<List<DataDokter>?> listDataDokter() async {
    try {
      final response = await NetworkProvider().getDataNoApplyDokter();
      listDokter = response?.data ?? [];
      filterDokterList = response?.data?.where((e) => e.statusBatch == 'confirm courier').toList() ?? [];
      notifyListeners();
      return listDokter;
    } catch (e) {
      print(e);
    }
  }

  void filterPesakitList(String query) {
    filterDokterList = listDokter
        ?.where((pesakit) {
          return (pesakit.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (pesakit.nama?.toLowerCase().contains(query.toLowerCase()) ?? false)  ||
              (pesakit.hospital?.alamat!.toLowerCase().contains(query.toLowerCase()) ?? false);
    })
        .toList();
    notifyListeners();
  }

  void filterTanggalDokterList(String query) {
    filterDokterList = listDokter
        ?.where((pesakit) =>
            pesakit.tanggal!.toLowerCase().contains(query.toLowerCase()))
        .toList();
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

  //getLatLong
  Future<Position> getGeolocationPosition() async{
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable){
      await Geolocator.openLocationSettings();
      return Future.error("Location service not enable");
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permission denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error(
          "Location permission denied forever, we cannot access"
      );
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy:  LocationAccuracy.high
    );
    try{
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
      currentAddress = '${place.subLocality}, ${place.locality}, ${place.country}';
      notifyListeners();
    }catch(exp){
      print(exp);
    }

    return position;

  }

}
