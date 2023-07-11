import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/location_service.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Timer.periodic(Duration(minutes: 5), (timer) async {
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

    // Mendapatkan posisi saat ini menggunakan Geolocator
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Lakukan tindakan yang diperlukan dengan posisi
    double latitude = position.latitude;
    double longitude = position.longitude;

    try {
      final ref = FirebaseDatabase.instance.ref();
      final userRef = ref.child('DriversKKM').child('${dataGlobal.data?.user?.id}');
      final postData = {
        'id': dataGlobal.data?.user?.id.toString(),
        'name': dataGlobal.data?.user?.fullName.toString(),
        'phone_number': dataGlobal.data?.user?.telp.toString(),
        'level': dataGlobal.data?.user?.level.toString(),
        'profil': dataGlobal.data?.user?.photo.toString(),
        'gender': dataGlobal.data?.user?.gender.toString(),
        'created_at': dataGlobal.data?.user?.createdAt.toString(),
        'updated_at': dataGlobal.data?.user?.updatedAt.toString(),
      };

      final LatLngMaps = {
        'latitude': '$latitude',
        'longitude': '$longitude',
      };

      // Check if the user exists in the database
      final dataSnapshot = await userRef.once();
      final isUserExist = dataSnapshot.snapshot.value != null;

      if (isUserExist) {
        // User exists, update the data
        await userRef.update(postData);
        await userRef.child('location').update(LatLngMaps);
      } else {
        // User doesn't exist, add the data
        await userRef.set(postData);
        await userRef.child('location').set(LatLngMaps);
      }
    } catch (exp) {
      print(exp);
    }


    print('Background - Latitude: $latitude, Longitude: $longitude');
  });

  // Pushy.listen();
  // Pushy.setNotificationIcon('ic_notification');
  // Pushy.toggleInAppBanner(true);
  // Pushy.setNotificationListener(backgroundNotificationListener);
  // Inisialisasi BackgroundFetch
  // BackgroundFetch.configure(
  //   BackgroundFetchConfig(
  //     minimumFetchInterval: 1, // Interval waktu pembaruan (dalam menit)
  //     stopOnTerminate: true, // Tetap berjalan saat aplikasi di-close
  //     enableHeadless: true, // Mengaktifkan mode headless background fetch
  //     requiresBatteryNotLow: false,
  //     requiresCharging: false,
  //     requiresDeviceIdle: false,
  //     requiresStorageNotLow: false,
  //   ),
  //   LocationService().backgroundFetchCallback,
  // );
  //
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

  runApp(const MyApp());
}

// void backgroundFetchHeadlessTask(String taskId) async {
//   print("[BackgroundFetch] Headless event received.");
//
//   // Pastikan Anda mendapatkan data notifikasi yang diperlukan dari push notification
//   Map<String, dynamic> data = {}; // Ganti dengan data notifikasi yang sesuai
//
//   String notificationTitle = data['title'] ?? 'MyApp';
//   String notificationText = data['message'] ?? 'Hello World!';
//   Pushy.notify(notificationTitle, notificationText, data);
//
//   // Clear iOS app badge number
//   Pushy.clearBadge();
//
//   BackgroundFetch.finish(taskId);
// }
//
// void backgroundNotificationListener(Map<String, dynamic> data) {
//   print('Received notification: $data');
//
//   String notificationTitle = data['title'] ?? 'MyApp';
//   String notificationText = data['message'] ?? 'Hello World!';
//   Pushy.notify(notificationTitle, notificationText, data);
//
//   // Clear iOS app badge number
//   Pushy.clearBadge();
// }


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
