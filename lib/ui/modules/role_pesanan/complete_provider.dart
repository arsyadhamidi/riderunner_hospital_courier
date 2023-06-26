
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class CompleteProvider extends ChangeNotifier{

  List<DataDokter>? listComplete;
  bool isLoading = true;

  CompleteProvider(){
    listDataComplete();
  }

  Future<List<DataDokter>?> listDataComplete() async{
    try{
      final response = await NetworkProvider().getDataDokter();
      listComplete = response?.data?.where((e) => e.statusBatch == 'Telah Terselesaikan').toList() ?? [];
      notifyListeners();
      return listComplete;
    }catch(e){
      print(e);
    }
  }

}