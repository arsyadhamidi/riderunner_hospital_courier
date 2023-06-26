import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class SedangDikirimProvider extends ChangeNotifier{

  List<DataDokter>? listDikirm;
  bool isLoading = true;

  SedangDikirimProvider(){
    listDataSedangDikirim();
  }

  Future<List<DataDokter>?> listDataSedangDikirim() async{
    final response = await NetworkProvider().getDataDokter();
    listDikirm = response?.data?.where((e) => e.statusBatch == 'Sedang Dikirim').toList() ?? [];
    notifyListeners();
    return listDikirm;
  }

}