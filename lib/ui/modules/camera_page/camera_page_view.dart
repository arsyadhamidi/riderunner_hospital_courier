import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_camera_page/detail_camera_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';

class CameraPageView extends StatefulWidget {

  final DataPesakit? data;
  final dynamic statusBatch;

  CameraPageView({Key? key, required this.data, required this.statusBatch,}) : super(key: key);

  @override
  State<CameraPageView> createState() => _CameraPageViewState();
}

class _CameraPageViewState extends State<CameraPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailObatProvider(),
      child: Consumer<DetailObatProvider>(
        builder: (context, detailObatProvider, child) {
          final detailObatProvider = Provider.of<DetailObatProvider>(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: FutureBuilder(
              future: detailObatProvider.initializeCamera(),
              builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done)
                  ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    child: CameraPreview(detailObatProvider.controller!),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 160,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MaterialButton(
                            onPressed: () async {
                              if (!detailObatProvider.controller!.value.isTakingPicture) {
                                File? imageFile = await detailObatProvider.takePhoto();
                                if (imageFile != null) {
                                  detailObatProvider.imageFiles = imageFile;
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    DetailCameraPageView(
                                    imageView: detailObatProvider.imageFiles!,
                                      obats: widget.data,
                                      statusBatch: widget.statusBatch,
                                )));
                              }
                            },
                            shape: CircleBorder(),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}


