
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/model_waiting.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingConfirmedProvider extends ChangeNotifier{

  Data? getWaiting;
  String token = '';

  WaitingConfirmedProvider(){
    getPref();
  }

  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("batch_id") ?? '';
    listDataWaitingConfirmed(token);
    notifyListeners();
  }

  Future<void> listDataWaitingConfirmed(id) async{
    final response = await NetworkProvider().getDataRealTime(token);
    getWaiting = response?.data;
    notifyListeners();
  }

}