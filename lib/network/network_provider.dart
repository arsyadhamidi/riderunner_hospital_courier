
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:http/http.dart' as http;
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';

class NetworkProvider{

  Future<ModelDokter?> getDataDokter() async{
    final response = await http.get(Uri.parse(ApiConfig.url + "api/branch/tasker"),
    headers: <String, String>{'Authorization': 'Bearer ${dataGlobal.data?.token}'});

    print(response.statusCode);
    print("Token : ${dataGlobal.data?.token}");

    ModelDokter getDokter = await modelDokterFromJson(response.body);
    return getDokter;
  }

  Future<ModelDokter?> getDataNoApplyDokter() async{
    final response = await http.get(Uri.parse(ApiConfig.url + "api/branch"),
        headers: <String, String>{'Authorization': 'Bearer ${dataGlobal.data?.token}'});

    print(response.statusCode);
    print("Token : ${dataGlobal.data?.token}");

    ModelDokter getDokter = await modelDokterFromJson(response.body);
    return getDokter;
  }
  
  Future<ModelPesakit?> getDataPesakit(id) async{
    final response = await http.get(Uri.parse(ApiConfig.url + "api/pesakit/${id}"),
        headers: <String, String>{'Authorization': 'Bearer ${dataGlobal.data?.token}'});

    ModelPesakit getPesakit = await modelPesakitFromJson(response.body);
    return getPesakit;
  }


  

}