import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider extends ChangeNotifier{

  HomePageProvider(){
    init();
  }

  init(){
    getDataUser();
  }

  Future<void> getDataUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login =  prefs.getString('dataUser');
    print(jsonDecode(login ?? ""));
    dataGlobal.data = modelUserFromJson(login ?? "");
  }

}