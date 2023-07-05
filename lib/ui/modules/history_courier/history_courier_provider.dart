import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class HistoryCourierProvider extends ChangeNotifier{

  List<DataDokter>? listHistory;
  List<DataDokter>? filterHistoryList = [];
  TextEditingController isDateSearchTxt = TextEditingController();
  bool isLoading = true;
  int rowPesakit = 0;
  int rowObat = 0;

  HistoryCourierProvider(){
    listDataHistory();
    refreshHistory();
  }

  Future<void> refreshHistory() async{
    await listDataHistory();
  }

  Future<List<DataDokter>?> listDataHistory() async{
    try{
      final response = await NetworkProvider().getDataDokter();
      listHistory = response?.data?.where((e) => e.statusBatch == 'Telah Terselesaikan').toList() ?? [];
      filterHistoryList = response?.data?.where((e) => e.statusBatch == 'Telah Terselesaikan').toList() ?? [];
      rowPesakit = listHistory?.length ?? 0;
      // rowObat = listHistory?.map((e) => e..pesakit).length ?? 0;
      notifyListeners();
      return listHistory;
    }catch(e){
      print(e);
    }
  }

  void filterPesakitList(String query) {
    filterHistoryList = listHistory
        ?.where((e) {
      return (e.doctor?.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (e.batch?.nama?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).where((f) => f.statusBatch == 'Telah Terselesaikan')
        .toList();
    notifyListeners();
  }

  void filterTanggalDokterList(String query) {
    filterHistoryList = listHistory
        ?.where((e) =>
        e.batch?.tanggal?.toLowerCase().contains(query.toLowerCase()) ?? false).where((f) => f.statusBatch == 'Telah Terselesaikan')
        .toList();
    notifyListeners();
  }


}