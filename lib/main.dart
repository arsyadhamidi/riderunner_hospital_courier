import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:riderunner_hospital_courier/location_service.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Pushy.listen();
  Pushy.setNotificationIcon('ic_notification');
  Pushy.toggleInAppBanner(true);
  Pushy.setNotificationListener(backgroundNotificationListener);
  // Inisialisasi BackgroundFetch
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 5, // Interval waktu pembaruan (dalam menit)
      stopOnTerminate: false, // Tetap berjalan saat aplikasi di-close
      enableHeadless: true, // Mengaktifkan mode headless background fetch
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    ),
    LocationService().backgroundFetchCallback,
  );

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

  runApp(const MyApp());
}

void backgroundFetchHeadlessTask(String taskId) async {
  print("[BackgroundFetch] Headless event received.");

  // Pastikan Anda mendapatkan data notifikasi yang diperlukan dari push notification
  Map<String, dynamic> data = {}; // Ganti dengan data notifikasi yang sesuai

  String notificationTitle = data['title'] ?? 'MyApp';
  String notificationText = data['message'] ?? 'Hello World!';
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();

  BackgroundFetch.finish(taskId);
}

void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');
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
