import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_waiting.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SedangDikirimProvider extends ChangeNotifier{

  Data? getDikirm;
  String token = '';

  SedangDikirimProvider(){
    getPref();
  }

  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("batch_id") ?? '';
    listDataSedangDikirim(token);
    notifyListeners();
  }

  Future<void> listDataSedangDikirim(id) async{
    final response = await NetworkProvider().getDataRealTime(token);
    getDikirm = response?.data;
    notifyListeners();
  }

}