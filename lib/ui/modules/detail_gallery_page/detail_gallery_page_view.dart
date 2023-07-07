import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';

class DetailGalleryPageView extends StatefulWidget {
  final File? imageView;
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
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailObatPage(
                          data: widget.obats,
                          statusBatch: widget.statusBatch,
                          shippingCost: null,
                          fileImage: widget.imageView!)));
                    },
                    child: Text("Selesai")
                )
              ],
            ),
            body: widget.imageView != null
                ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.file(widget.imageView!))
                : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
