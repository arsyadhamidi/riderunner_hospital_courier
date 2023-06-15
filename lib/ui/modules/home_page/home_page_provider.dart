import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/user_model.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider extends ChangeNotifier{

  HomePageProvider(){
    init();
  }

  init(){
    getDataUser();
  }

  List<DataDokter>? listDokter;
  List<DataDokter>? filterDokterList = [];

  Future<void> getDataUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login =  prefs.getString('dataUser');
    print(jsonDecode(login ?? ""));
    dataGlobal.data = modelUserFromJson(login ?? "");

    listDataDokter();
  }

    Future<List<DataDokter>?> listDataDokter() async{
      try{
        final response = await NetworkProvider().getDataDokter();
        listDokter = response?.data ?? [];
        filterDokterList = response?.data ?? [];
        notifyListeners();
        return listDokter;
      }catch(e){
        print(e);
      }
    }

  void filterPesakitList(String query) {
    filterDokterList = listDokter
        ?.where((pesakit) => pesakit.nama!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

  void filterTanggalDokterList(String query){
    filterDokterList = listDokter
        ?.where((pesakit) => pesakit.tanggal!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

}