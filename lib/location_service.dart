import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';

class LocationService{

  void backgroundFetchCallback(String taskId) async {

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

    Future.delayed(Duration(minutes: 5), () async {
      try {
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

        await ref
            .child('DriversTesting')
            .child('${dataGlobal.data?.user?.id}')
            .update(postData);
        await ref
            .child('DriversTesting')
            .child('${dataGlobal.data?.user?.id}')
            .child('location')
            .update(LatLngMaps);
      } catch (exp) {
        print(exp);
      }
    });


    print('Background Fetch - Latitude: $latitude, Longitude: $longitude');

    // Update posisi ke server atau tempat penyimpanan lainnya

    // Complete the background fetch task
    BackgroundFetch.finish(taskId);
  }

}