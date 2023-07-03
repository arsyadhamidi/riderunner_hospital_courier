
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:http/http.dart' as http;
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_view.dart';

class DetailObatProvider extends ChangeNotifier{

  File? imageFiles = null;
  CameraController? controller;

  Future<void> initializeCamera() async{
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
    String filePath = '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

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
    try{
      var image = await ImagePicker.platform.pickImage(
          source: ImageSource.gallery
      );
      var takeGallery = imageFiles = File(image!.path);
      notifyListeners();
      print('Contoh Satunya : ${takeGallery}');
    }catch(exp){
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

}