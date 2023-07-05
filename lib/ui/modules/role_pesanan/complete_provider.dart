
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_waiting.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProvider extends ChangeNotifier{

  Data? getComplete;
  String token = '';

  CompleteProvider(){
    getPref();
  }

  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("batch_id") ?? '';
    listDataComplete(token);
    notifyListeners();
  }

  Future<void> listDataComplete(id) async{
    try{
      final response = await NetworkProvider().getDataRealTime(token);
      getComplete = response?.data;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

}