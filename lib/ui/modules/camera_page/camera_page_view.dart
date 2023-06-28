import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/camera_page/camera_page_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';

class CameraPageView extends StatefulWidget {
  const CameraPageView({Key? key}) : super(key: key);

  @override
  State<CameraPageView> createState() => _CameraPageViewState();
}

class _CameraPageViewState extends State<CameraPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailObatProvider(),
      child: Consumer<DetailObatProvider>(
        builder: (context, obatProvider, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: FutureBuilder(
              future: obatProvider.initializeCamera(),
              builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done)
                  ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    child: CameraPreview(obatProvider.controller!),
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
                              if (!obatProvider.controller!.value.isTakingPicture) {
                                File? result = await obatProvider.takePhoto();
                                Navigator.pop(context);
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
