
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class TobePickupProvider extends ChangeNotifier{

  List<DataDokter>? listTobe;
  bool isLoading = true;

  TobePickupProvider(){
    listDataTobePickup();
    refreshTobe();
  }

  Future<void> refreshTobe() async{
    await listDataTobePickup();
  }

  Future<List<DataDokter>?> listDataTobePickup() async{
    final response = await NetworkProvider().getDataDokter();
    listTobe = await response?.data?.where((e) => e.statusBatch == 'Take Medicine on Hospital').toList() ?? [];
    notifyListeners();
    return listTobe;
  }


}