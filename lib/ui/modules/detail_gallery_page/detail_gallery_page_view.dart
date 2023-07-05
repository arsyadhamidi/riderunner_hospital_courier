import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';

class DetailGalleryPageView extends StatefulWidget {
  final dynamic imageView;
  final DataPesakit? obats;
  final dynamic statusBatch;

  DetailGalleryPageView(
      {Key? key,
      required this.imageView,
      required this.obats,
      required this.statusBatch})
      : super(key: key);

  @override
  State<DetailGalleryPageView> createState() => _DetailGalleryPageViewState();
}

class _DetailGalleryPageViewState extends State<DetailGalleryPageView> {
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
                  aspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height,
                  child: widget.imageView != null
                      ? Image.file(widget.imageView as File)
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
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
                widget.imageView != false && widget.imageView != null ? Positioned(
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
                            await detailObatProvider.initializeCamera();
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Testing(
                            //   fileImage: widget.imageView,
                            // )));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailObatPage(
                                    data: widget.obats,
                                    statusBatch: widget.statusBatch,
                                    shippingCost: null,
                                    fileImage: widget.imageView!,
                                  ),
                                ));

                            setState(() {
                              var dataY = detailObatProvider.imageFiles =
                                  widget.imageView!;
                              print('Gambar Print : ${dataY}');
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
                ) : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
