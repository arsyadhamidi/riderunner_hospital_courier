
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class DetailHistoryCourierProvider extends ChangeNotifier{

  int? id;
  List<DataPesakit>? listPesakit;

  DetailHistoryCourierProvider(this.id){
    listHistoryPesakit(id);
    refreshPesakit(id);
  }

  Future<void> refreshPesakit(id) async{
    await listHistoryPesakit(id);
  }

  Future<List<DataPesakit>?> listHistoryPesakit(id) async{
    final response = await NetworkProvider().getDataPesakit(id);
    listPesakit = response?.data ?? [];
    notifyListeners();
    return listPesakit;
  }


}