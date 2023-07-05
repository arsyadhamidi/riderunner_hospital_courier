import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/attachments_page/attachments_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/camera_page/camera_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_gallery_page/detail_gallery_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';
import 'package:side_sheet/side_sheet.dart';

class DetailObatPage extends StatefulWidget {
  final DataPesakit? data;
  final dynamic statusBatch;
  final dynamic shippingCost;
  final dynamic fileImage;

  DetailObatPage({Key? key, required this.data, required this.statusBatch, required this.shippingCost,  required this.fileImage})
      : super(key: key);

  @override
  State<DetailObatPage> createState() => _DetailObatPageState();
}

class _DetailObatPageState extends State<DetailObatPage> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context) => DetailObatProvider(),
      child: Consumer<DetailObatProvider>(
        builder: (context, detailObatProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      SideSheet.right(
                          sheetColor: Colors.white,
                          body: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 71, 255, 1),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    )),
                                height: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Nama Courier",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          "Nama Courier",
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),
                                        Spacer(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Job List",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Text("99+")
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Waiting Confirmed",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Text("1"),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "To Be Pick Up",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        // Text("1"),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Complete",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        // Text("1"),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "History",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        // Text("1"),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.doc_append,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Rejected",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        // Text("1"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          context: context);
                    },
                    icon: Icon(Icons.format_align_justify,
                        color: Colors.black)),
                SizedBox(width: 10),
              ],
            ),
            body: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('Orders_kkm')
                  .child('${detailObatProvider.token}')
                  .child('status_batch')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final statusBatch = snapshot.data!.snapshot.value;
                  print(statusBatch);
                  return statusBatch == 'Take Medicine on Hospital'
                      ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("This Assignment has not been Approved"),
                            ),
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 30, top: 15, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${widget.data?.pesakit?.nama}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          width: 300,
                                          child: Text(
                                              "${widget.data?.pesakit?.negeri}, ${widget.data?.pesakit?.houseNumber}, Kode Pos : ${widget.data?.pesakit?.kodePos}")),
                                      SizedBox(height: 5),
                                      Text(
                                          "Telp : ${widget.data?.pesakit?.phoneNumber}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text("Medicine to be Delivered",
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 71, 255, 1),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: widget.data?.obats?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final obat = widget.data?.obats?[index];
                                          return Column(
                                            children: [
                                              ListTile(
                                                leading: Checkbox(
                                                  onChanged: (value) {
                                                    setState(() {

                                                      widget.data?.obats?.forEach((e) {
                                                        obat?.isChecked = true;
                                                      });

                                                      obat?.isChecked = value!;
                                                    });
                                                  },
                                                  value: obat?.isChecked ?? false,
                                                ),
                                                title: Text('${obat?.namaObat}'),
                                                trailing: Text(
                                                  '${obat?.jumlahObat}',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: ListTile(
                                        leading: Image.asset(
                                          "assets/images/cost.png",
                                          scale: 10,
                                        ),
                                        title: Text(
                                          "Cost Penghantaran",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Text("RM 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.payments,
                                          size: 50,
                                        ),
                                        title: Text(
                                          "Total Harga",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Text(
                                            "RM ${widget.data?.totalHarga}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AttachmentsPageView(
                                    imageView: widget.fileImage!)));
                              },
                              child: Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Center(
                                    child: widget.fileImage != null
                                        ? Image.file(widget.fileImage)
                                        : Text("No Image")
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      )),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Add Proof",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 20),
                                            InkWell(
                                              onTap: () {
                                                detailObatProvider
                                                    .pickImageFromGallery();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGalleryPageView(
                                                    imageView: detailObatProvider.imageFiles,
                                                    obats: widget.data,
                                                    statusBatch: widget.statusBatch
                                                )));
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/gallery.png',
                                                    scale: 15,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text("Choose Photo")
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Divider(),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CameraPageView(
                                                              data: widget.data,
                                                              statusBatch: widget.statusBatch,
                                                            )));
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/camera.png',
                                                    scale: 15,
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text("Take Photo")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 10, right: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add, color: Colors.blue, size: 50),
                                        SizedBox(width: 15),
                                        Text(
                                          "ADD PROOF",
                                          style:
                                          TextStyle(fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      ],
                    ),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("This Assignment has not been Approved"),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 30, top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.data?.pesakit?.nama}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      width: 300,
                                      child: Text(
                                          "${widget.data?.pesakit?.negeri}, ${widget.data?.pesakit?.houseNumber}, Kode Pos : ${widget.data?.pesakit?.kodePos}")),
                                  SizedBox(height: 5),
                                  Text(
                                      "Telp : ${widget.data?.pesakit?.phoneNumber}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text("Medicine to be Delivered",
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 71, 255, 1),
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.data?.obats?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final obat = widget.data?.obats?[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: Image.asset(
                                                'assets/images/obat.png'),
                                            title: Text('${obat?.namaObat}'),
                                            trailing: Text(
                                              '${obat?.jumlahObat}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/images/cost.png",
                                      scale: 10,
                                    ),
                                    title: Text(
                                      "Cost Penghantaran",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: widget.shippingCost == null ? Text("RM 0.00") : Text("RM ${widget.shippingCost.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.payments,
                                      size: 50,
                                    ),
                                    title: Text(
                                      "Total Harga",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Text(
                                        "RM ${widget.data?.totalHarga}.00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(20),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color.fromRGBO(0, 71, 255, 1),
                child: Text(
                  "Complete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}

