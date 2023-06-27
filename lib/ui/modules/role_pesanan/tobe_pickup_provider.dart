
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';

class TobePickupProvider extends ChangeNotifier{

  List<DataDokter>? listTobe;
  bool isLoading = true;
  double distance = 0.0;
  double travelTime = 0.0;
  int travelTimeInMinutes = 0;
  double travelCost = 0;
  String currentAddress = 'Your Location';

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

  //getLatLong
  Future<Position> getGeolocationPosition() async{
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable){
      await Geolocator.openLocationSettings();
      return Future.error("Location service not enable");
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permission denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error(
          "Location permission denied forever, we cannot access"
      );
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy:  LocationAccuracy.high
    );

    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    List<LatLng>? destinationLocation = listTobe?.map((e) {
      return LatLng(double.parse('${e.hospital?.latitude}'), double.parse('${e.hospital?.longitude}'));
    }).toList();


    if (currentLocation != null && destinationLocation != null && destinationLocation.isNotEmpty) {
      distance = Distance().as(
        LengthUnit.Kilometer,
        currentLocation,
        destinationLocation[0],
      );
    }


    double averageSpeed = 50.0; // Kecepatan rata-rata dalam km/jam
    travelTime = (distance / averageSpeed) * 60.0; // Waktu perjalanan dalam jam
    travelTimeInMinutes = travelTime.round();
    travelCost = distance * 0.05;
    notifyListeners();

    try{
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
      currentAddress = '${place.subLocality}, ${place.locality}, ${place.country}';
      notifyListeners();
    }catch(exp){
      print(exp);
    }

    return position;

  }


}