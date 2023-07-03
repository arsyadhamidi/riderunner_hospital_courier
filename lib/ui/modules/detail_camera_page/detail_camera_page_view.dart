import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';

class DetailCameraPageView extends StatefulWidget {

  final dynamic imageView;
  final DataPesakit? obats;
  final dynamic statusBatch;

  DetailCameraPageView({Key? key, required this.imageView, required this.obats, required this.statusBatch}) : super(key: key);

  @override
  State<DetailCameraPageView> createState() => _DetailCameraPageViewState();
}

class _DetailCameraPageViewState extends State<DetailCameraPageView> {

  final detailObatProvider = DetailObatProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailObatProvider(),
      child: Consumer<DetailObatProvider>(
        builder: (context, detailObatProvider, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                  child: Image.file(widget.imageView, fit: BoxFit.cover,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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

                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                DetailObatPage(
                                    data: widget.obats,
                                    statusBatch: widget.statusBatch,
                                  shippingCost: null,
                                ),
                            ));

                            setState(() {
                              detailObatProvider.imageFiles = widget.imageView!;
                            });


                          },
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: Center(
                            child: Icon(Icons.check),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
