
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCourierProvider extends ChangeNotifier {

  int? id;
  List<DataPesakit>? listPesakit;
  List<DataDokter>? listDokter;
  bool isLoading = true;
  bool isApply = false;
  List<LatLng> routeCoords = [];
  double latMaps = 0.0;
  double longMaps = 0.0;
  int rowCount = 0;
  late bool isButtonClicked = false;
  String countDokter = '';

  DetailCourierProvider(this.id) {
    listDataPesakit(id);
    getpositionMaps();
    refreshCourier(id);
    listDataDokter();
  }

  Future<void> refreshCourier(id) async{
    await listDataPesakit(id);
  }

  Future<void> listDataPesakit(id) async {
    final response = await NetworkProvider().getDataPesakit(id);
    listPesakit = response?.data ?? [];
    rowCount = listPesakit?.length ?? 0;
    notifyListeners();
  }

  Future<List<DataDokter>?> listDataDokter() async {
    try {
      final response = await NetworkProvider().getDataNoApplyDokter();
      listDokter = response?.data ?? [];
      countDokter = (response?.data?.where((e) => e.statusBatch == 'confirm courier').length).toString();
      notifyListeners();
      countDokter = int.parse(countDokter) > 10 ? "9+" : countDokter;
      return listDokter;
    } catch (e) {
      print(e);
    }
  }

  void logoutAuth(BuildContext context) async {
    final response = await http.delete(Uri.parse(ApiConfig.url + "api/logout"),
        headers: <String, String>{
          'Authorization': 'Bearer ${dataGlobal.data?.token}'
        });

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (contex) => SplashScreenPageView()),
              (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Logout Failed!",
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  Future<void> getRoute(origin, destination) async {
    final url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${origin
        .longitude},${origin.latitude};${destination.longitude},${destination
        .latitude}?alternatives=true&exclude=toll&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    final route = data['routes'][0]['geometry']['coordinates'];
    routeCoords = route
        .map((point) => LatLng(point[1], point[0]))
        .toList()
        .cast<LatLng>();
    notifyListeners();
  }

  Future<void> addOrUpdateDataInRealtimeDatabase(BuildContext context, String batchId) async {
    final ref = FirebaseDatabase.instance.ref().child('Orders_kkm').child(batchId);

    // Periksa apakah data sudah ada di realtime database
    final dataSnapshot = await ref.once();
    final isDataExist = dataSnapshot.snapshot.value != null;

    if (isDataExist) {
      // Data sudah ada, lakukan update
      await updateDataInRealtimeDatabase(ref);
      await saveBatchId(batchId);
    } else {
      // Data belum ada, tambahkan data baru
      await addDataToRealtimeDatabase(ref, batchId);
      await saveBatchId(batchId);
    }
  }

  Future<void> addDataToRealtimeDatabase(DatabaseReference ref, String batchId) async {
    try {
      final postData = {
        'batch_id': batchId.toString(),
        'status_batch': 'waiting confirmed',
      };
      await ref.set(postData);
    } catch (e) {
      print('Error adding data to realtime database: $e');
    }
  }

  Future<void> updateDataInRealtimeDatabase(DatabaseReference ref) async {
    try {
      await ref.update({'status_batch': 'waiting confirmed'});
    } catch (e) {
      print('Error updating data in realtime database: $e');
    }
  }

  Future<void> saveBatchId(String batchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('batch_id', batchId);
  }

  Future<void> addApplyThisJob(BuildContext context, String batchId, double latitude, double longitude) async{
    final response = await http.post(Uri.parse(ApiConfig.url + 'api/confirm'),
        headers: <String, String>{'Authorization': 'Bearer ${dataGlobal.data?.token}'},
      body: {
        'batch_id': batchId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }
    );
    await jsonDecode(response.body);

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text("Apply This Job Successfully!", style: TextStyle(color: Colors.white))
          )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Apply This Job Failed!", style: TextStyle(color: Colors.white))
        )
      );
    }

  }

  Future<void> updateDataCost(BuildContext context, id, String cost) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "api/branch/cost/${id}"), body: {
      'cost': cost.toString(),
    },
      headers: <String, String>{'Authorization': 'Bearer ${dataGlobal.data?.token}'});

    await jsonDecode(response.body);

    print(response.body);

    if(response.statusCode == 200){
     //
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text("Failed Apply This Job", style: TextStyle(color: Colors.white))
          )
      );
    }
  }

  void getpositionMaps() async{

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check and request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied.');
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Retrieve latitude and longitude
    latMaps = position.latitude;
    longMaps = position.longitude;

    print('Latitude: $latMaps');
    print('Longitude: $longMaps');

    notifyListeners();

  }

}