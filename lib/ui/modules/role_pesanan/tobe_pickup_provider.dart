
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/model_waiting.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TobePickupProvider extends ChangeNotifier{

  Data? getTobe;
  bool isLoading = true;
  String token = '';

  TobePickupProvider(){
    getPref();
  }
  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("batch_id") ?? '';
    listDataTobePickup(token);
    notifyListeners();
  }

  Future<List<DataDokter>?> listDataTobePickup(id) async{
    final response = await NetworkProvider().getDataRealTime(token);
    getTobe = response?.data;
    notifyListeners();
  }


}