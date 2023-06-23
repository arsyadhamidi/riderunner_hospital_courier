import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class HistoryCourierProvider extends ChangeNotifier{

  List<DataDokter>? listHistory;

  HistoryCourierProvider(){
    listDataHistory();
  }

  Future<List<DataDokter>?> listDataHistory() async{
    try{
      final response = await NetworkProvider().getDataDokter();
      listHistory = await response?.data?.where((e) => e.statusBatch == 'Telah Terselesaikan').toList() ?? [];
      notifyListeners();
      return listHistory;
    }catch(e){
      print(e);
    }
  }


}