import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  Timer.periodic(Duration(minutes: 5), (Timer timer) async {
    // Kode yang akan dijalankan berulang setiap 5 minute

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
      double latitude = position.latitude;
      double longitude = position.longitude;

      print('Latitude: $latitude');
      print('Longitude: $longitude');

      Future.delayed(Duration(minutes: 5), () async{
        try{
          final ref = FirebaseDatabase.instance.ref();
          final postData = {
            'id': dataGlobal.data?.user?.id.toString(),
            'name': dataGlobal.data?.user?.name.toString(),
            'phone_number': dataGlobal.data?.user?.phoneNumber.toString(),
            'level': dataGlobal.data?.user?.level.toString(),
            'profil': dataGlobal.data?.user?.profil.toString(),
            'gender': dataGlobal.data?.user?.gender.toString(),
            'created_at': dataGlobal.data?.user?.createdAt.toString(),
            'updated_at': dataGlobal.data?.user?.updatedAt.toString(),
          };

          final LatLngMaps = {
            'latitude': '$latitude',
            'longitude': '$longitude',
          };

          await ref.child('DriversTesting').child('${dataGlobal.data?.user?.id}').update(postData);
          await ref.child('DriversTesting').child('${dataGlobal.data?.user?.id}').child('location').update(LatLngMaps);

        }catch(exp){
          print(exp);
        }
      });
    }
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

