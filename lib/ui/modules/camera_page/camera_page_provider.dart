
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraPageProvider extends ChangeNotifier{

  File? imageFiles;
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

  Future<File?> takePhoto() async{
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/Guided_Camera';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '${directoryPath}/${DateTime.now()}.jpg';

    try{
      XFile? picture = await controller?.takePicture();
      imageFiles = File(picture!.path);
      await imageFiles?.copy(filePath);
      return imageFiles;
    }catch(e){
      return null;
    }

  }

}