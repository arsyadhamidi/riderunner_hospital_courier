import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/conn/connectivity_check.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:http/http.dart' as http;
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/network/network_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailObatProvider extends ChangeNotifier {
  List<DataDokter>? listDokter;
  File? imageFiles = null;
  CameraController? controller;
  String token = '';
  String countDokter = '';

  DetailObatProvider() {
    getPref();
    listDataDokter();
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("batch_id") ?? '';
    notifyListeners();
  }

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller?.initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<File?> takePhoto() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/Guided_Camera';
    await Directory(directoryPath).create(recursive: true);
    String filePath =
        '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      XFile? picture = await controller?.takePicture();
      imageFiles = File(picture!.path);
      notifyListeners();
      print('Contoh Take Gambar : ${imageFiles}');
      await imageFiles!.copy(filePath);
      return imageFiles;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final image =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFiles = File(image!.path);
        notifyListeners();
      }
    } catch (exp) {
      print(exp);
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

  Future<List<DataDokter>?> listDataDokter() async {
    try {
      final response = await NetworkProvider().getDataNoApplyDokter();
      listDokter = response?.data ?? [];
      countDokter = (response?.data
              ?.where((e) => e.statusBatch == 'confirm courier')
              .length)
          .toString();
      notifyListeners();
      countDokter = int.parse(countDokter) > 10 ? "9+" : countDokter;
      return listDokter;
    } catch (e) {
      print(e);
    }
  }

  Future<String?> editPesakitObat(BuildContext context,
      http.MultipartFile imgProof, String pesakitId, String batchId) async {
    try {
      final uri = Uri.parse(ApiConfig.url + "api/pesakitobat/edit");
      var request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes(
          'proof', File(imageFiles?.path ?? '').readAsBytesSync(),
          filename: imageFiles?.path.split("/").last));

      request.fields['pesakit_id'] = pesakitId.toString();
      request.fields['batch_id'] = batchId.toString();

      // Set token sebagai header
      request.headers['Authorization'] = 'Bearer ${dataGlobal.data?.token}';

      var res = await request.send();
      log(res.toString());

      if (res.statusCode == 200) {
        Navigator.pop(context);
        return res.reasonPhrase;
      } else {
        Fluttertoast.showToast(
          msg: "Sila Coba Lagi!",
          toastLength: Toast
              .LENGTH_SHORT, // Durasi toast (Toast.LENGTH_SHORT atau Toast.LENGTH_LONG)
          gravity: ToastGravity
              .BOTTOM, // Posisi toast (ToastGravity.TOP, ToastGravity.CENTER, atau ToastGravity.BOTTOM)
          timeInSecForIosWeb: 1, // Durasi toast untuk iOS dan web (dalam detik)
          backgroundColor: Colors.black54, // Warna latar belakang toast
          textColor: Colors.white, // Warna teks toast
          fontSize: 16.0, // Ukuran teks toast
        );
      }
    } catch (e) {
      if (e is SocketException) {
        // Tidak ada koneksi jaringan
        ConnectivitCheck().showNoInternetConnection();
      } else if (e is HttpException) {
        // Server error
        ConnectivitCheck().showServerError();
      } else {
        // Tidak dapat terhubung
        ConnectivitCheck().showConnectionError();
      }
    }
  }

  Future<void> addOrUpdateDataInRealtimeDatabase(BuildContext context, String batchId) async {
    final ref = FirebaseDatabase.instance.ref().child('Orders_kkm').child(batchId);

    // Periksa apakah data sudah ada di realtime database
    final dataSnapshot = await ref.once();
    final isDataExist = dataSnapshot.snapshot.value != null;

    if (isDataExist) {
      // Data sudah ada, lakukan update
      await updateDataInRealtimeDatabase(ref);
    } else {
      // Data belum ada, tambahkan data baru
      await addDataToRealtimeDatabase(ref, batchId);
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
      await ref.update({'status_batch': 'Sedang Dikirim'});
    } catch (e) {
      print('Error updating data in realtime database: $e');
    }
  }
}
