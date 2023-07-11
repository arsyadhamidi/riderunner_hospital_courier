import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/model/model_dokter.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_courier_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_maps_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/history_courier/history_courier_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/profile_page/profile_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/complete_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/sedang_kirim_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/tobe_pickup_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/waiting_confirmed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';

class DetailCourierPage extends StatefulWidget {
  final DataDokter? data;
  final dynamic shipping;
  final dynamic jarak;
  final dynamic waktu;
  final dynamic batchId;
  final dynamic latitude;
  final dynamic longitude;

  DetailCourierPage(
      {Key? key,
      required this.data,
      required this.shipping,
      required this.jarak,
      required this.waktu,
      required this.batchId,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<DetailCourierPage> createState() => _DetailCourierPageState();
}

class _DetailCourierPageState extends State<DetailCourierPage> {
  late DatabaseReference ref; // Variable to track the condition

  @override
  void initState() {
    ref = FirebaseDatabase.instance
        .reference()
        .child('Orders_kkm')
        .child(widget.batchId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot data = snapshot.data!.snapshot;
          if (data.value != null) {
            var dataMap = data.value as Map<dynamic, dynamic>?;
            if (dataMap != null && dataMap['status_batch'] == 'confirm courier') {
              return ChangeNotifierProvider(
                create: (context) => DetailCourierProvider(widget.batchId),
                child: Consumer<DetailCourierProvider>(
                  builder: (context, detailProvider, child) {
                    return Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          title: Text(
                            "Courier Job List",
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  SideSheet.right(
                                      sheetColor: Colors.white,
                                      body: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(0, 71, 255, 1),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(25),
                                                    bottomRight: Radius.circular(25),
                                                  )),
                                              height: 200,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfilePageView()));
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      child: dataGlobal
                                                          .data?.user?.photo !=
                                                          null
                                                          ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(50),
                                                            child: Image.network(
                                                        "${ApiConfig.urlFoto}${dataGlobal.data?.user?.photo}",
                                                        errorBuilder: (context, error,
                                                              stackTrace) {
                                                            return ClipRRect(
                                                              borderRadius: BorderRadius.circular(50),
                                                              child: Image.asset(
                                                                  'assets/images/foto-profile.png'),
                                                            );
                                                        },
                                                      ),
                                                          )
                                                          : ClipRRect(
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: Image.asset(
                                                            'assets/images/foto-profile.png'),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          dataGlobal.data?.user?.fullName ?? '',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                              fontSize: 17),
                                                        ),
                                                        Text(
                                                          "${dataGlobal.data?.user?.level}",
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Job List",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        Text("${detailProvider.countDokter}")
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  WaitingConfirmedPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Waiting Confirmed",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        Text(""),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TobePickUpPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "To Be Pick Up",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SedangKirimPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Sedang Dikirim",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ComplatePage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Complete",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HistoryCourierPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "History",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons.doc_append,
                                                            size: 28,
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
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                                child: Text(
                                                                    "Are You Sure Logout ?")),
                                                            content: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: [
                                                                MaterialButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  elevation: 3,
                                                                  minWidth: 110,
                                                                  height: 50,
                                                                  child: Text("Not Sure"),
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          50),
                                                                      side: BorderSide(
                                                                          color: Colors
                                                                              .grey)),
                                                                ),
                                                                SizedBox(width: 10),
                                                                MaterialButton(
                                                                  onPressed: () async {
                                                                    var prefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                    prefs.clear();
                                                                    detailProvider.logoutAuth(
                                                                        context);
                                                                  },
                                                                  color: Color.fromRGBO(
                                                                      0, 71, 255, 1),
                                                                  minWidth: 110,
                                                                  height: 50,
                                                                  child: Text(
                                                                    "Logout",
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.white),
                                                                  ),
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(50),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.logout,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Logout",
                                                              style:
                                                              TextStyle(fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context: context);
                                },
                                icon:
                                Icon(Icons.format_align_justify, color: Colors.black)),
                            SizedBox(width: 10),
                          ],
                        ),
                        body: RefreshIndicator(
                          onRefresh: () =>
                              detailProvider.refreshCourier(widget.batchId),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          widget.data?.doctor?.photo != null
                                              ? Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${ApiConfig.urlFoto}${widget.data?.doctor?.photo}",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) {
                                                        return ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.asset('assets/images/foto-profile.png'));
                                                      },
                                                    ),
                                                    // child: Image.network(
                                                    //   "${ApiConfig.urlFoto}${widget.data?.doctor?.profil}",
                                                    //   fit: BoxFit.cover,
                                                    //   errorBuilder: (context,
                                                    //       error, stackTrace) {
                                                    //     return Image.asset('assets/images/foto-profile.png');
                                                    //   },
                                                    // ),
                                                  ),
                                                )
                                              : Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              child: Image.asset(
                                                "assets/images/foto-profile.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 240,
                                                  child: Text(
                                                      "${widget.data?.doctor?.fullName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16))),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "${widget.data?.doctor?.specialist}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Location",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Container(
                                                width: 180,
                                                child: Text(
                                                    "${widget.data?.hospital?.alamat}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Jumlah Pesakit",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text(
                                                  "${detailProvider.rowCount} Pesakit",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Batas Waktu",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text("${widget.data?.batch?.jam}",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Shipping Costs",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text(
                                                  "RM${widget.shipping.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 250,
                                      width: double.infinity,
                                      color: Color.fromRGBO(255, 184, 0, 1),
                                      child: Stack(
                                        children: [
                                          StreamBuilder(
                                            stream:
                                                Geolocator.getPositionStream(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              final position =
                                                  snapshot.data as Position;
                                              final myPosition = LatLng(
                                                  position.latitude,
                                                  position.longitude);
                                              final hospital = LatLng(
                                                  double.parse(
                                                      '${widget.data?.hospital?.latitude}'),
                                                  double.parse(
                                                      '${widget.data?.hospital?.longitude}'));
                                              detailProvider.getRoute(
                                                  myPosition, hospital);
                                              return FlutterMap(
                                                options: MapOptions(
                                                  center: hospital,
                                                  zoom: 15.0,
                                                ),
                                                nonRotatedChildren: [],
                                                children: [
                                                  TileLayer(
                                                    urlTemplate:
                                                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                    userAgentPackageName:
                                                        'com.example.app',
                                                    additionalOptions: {
                                                      'accessToken':
                                                          'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                      'id':
                                                          'mapbox/streets-v12',
                                                    },
                                                  ),
                                                  MarkerLayer(
                                                    markers: [
                                                      Marker(
                                                        point: hospital,
                                                        builder: (context) {
                                                          return Image.asset(
                                                              'assets/images/pin.png');
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailMapsPage(
                                                              latitude:
                                                                  double.parse(
                                                                      '${widget.data?.hospital?.latitude}'),
                                                              longitude:
                                                                  double.parse(
                                                                      '${widget.data?.hospital?.longitude}'),
                                                              jarak:
                                                                  widget.jarak,
                                                              waktu:
                                                                  widget.waktu,
                                                            )));
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 190,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${widget.data?.hospital?.rumahSakit}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 3),
                                                      Text(
                                                          "Lihat peta lebih besar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text("List Obat Pesakit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: detailProvider.isLoading
                                          ? (detailProvider.listPesakit == null
                                              ? Center(child: Text("No Data"))
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: detailProvider
                                                          .listPesakit
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      elevation: 3,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DetailObatPage(
                                                                            data:
                                                                                detailProvider.listPesakit?[index],
                                                                            statusBatch:
                                                                                widget.data?.statusBatch,
                                                                            shippingCost:
                                                                                widget.shipping,
                                                                            fileImage:
                                                                                null,
                                                                            batchId: widget.batchId
                                                                          )));
                                                        },
                                                        title: Text(
                                                          detailProvider
                                                                  .listPesakit?[
                                                                      index]
                                                                  .pesakit
                                                                  ?.nama ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ))
                                          : CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are You Sure to Take this job ?",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          elevation: 3,
                                          color: Colors.white,
                                          height: 50,
                                          minWidth: 120,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text("Not Sure"),
                                        ),
                                        SizedBox(width: 20),
                                        MaterialButton(
                                          onPressed: () {
                                            detailProvider
                                                .addOrUpdateDataInRealtimeDatabase(
                                              context,
                                              widget.batchId.toString(),
                                            );
                                            detailProvider.addApplyThisJob(
                                              context,
                                              widget.batchId.toString(),
                                              widget.latitude,
                                              widget.longitude,
                                            );
                                            detailProvider.updateDataCost(
                                              context,
                                              widget.data?.id.toString(),
                                              widget.shipping.toString(),
                                            );
                                            Navigator.pop(context);
                                          },
                                          elevation: 3,
                                          color: Colors.blue,
                                          height: 50,
                                          minWidth: 120,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Of Course",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            minWidth: double.infinity,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide.none,
                            ),
                            color: Colors.blue,
                            child: Text(
                              "Apply This Job",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              );
            }
            if (dataMap != null &&
                dataMap['status_batch'] == 'waiting confirmed') {
              return ChangeNotifierProvider(
                create: (context) => DetailCourierProvider(widget.batchId),
                child: Consumer<DetailCourierProvider>(
                  builder: (context, detailProvider, child) {
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
                          title: Center(
                              child: Text(
                            "Detail Task ${widget.data?.batch?.nama}",
                            style: TextStyle(color: Colors.black),
                          )),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  SideSheet.right(
                                      sheetColor: Colors.white,
                                      body: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 71, 255, 1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(25),
                                                    bottomRight:
                                                        Radius.circular(25),
                                                  )),
                                              height: 200,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 40,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.network(
                                                          "${ApiConfig.urlFoto}${dataGlobal.data?.user?.photo}"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                        dataGlobal.data?.user
                                                                ?.fullName ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                      Text(
                                                        "${dataGlobal.data?.user?.level}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Job List",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      Text("99+")
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  WaitingConfirmedPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Waiting Confirmed",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TobePickUpPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "To Be Pick Up",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SedangKirimPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Sedang Dikirim",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ComplatePage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Complete",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HistoryCourierPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .doc_append,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "History",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Rejected",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    onTap: () async {
                                                      var prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.clear();
                                                      detailProvider
                                                          .logoutAuth(context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.logout,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Logout",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                        // Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context: context);
                                },
                                icon: Icon(Icons.format_align_justify,
                                    color: Colors.black)),
                            SizedBox(width: 10),
                          ],
                        ),
                        body: RefreshIndicator(
                          onRefresh: () =>
                              detailProvider.refreshCourier(widget.data?.id),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          widget.data?.doctor?.photo == null
                                              ? CircularProgressIndicator()
                                              : Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${ApiConfig.urlFoto}${widget.data?.doctor?.photo}",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) {
                                                        return ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.asset('assets/images/foto-profile.png'));
                                                      },
                                                    ),
                                                    // child: Image.network(
                                                    //   "${ApiConfig.urlFoto}${widget.data?.doctor?.profil}",
                                                    //   fit: BoxFit.cover,
                                                    //   errorBuilder: (context,
                                                    //       error, stackTrace) {
                                                    //     return CircularProgressIndicator();
                                                    //   },
                                                    // ),
                                                  ),
                                                ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 240,
                                                  child: Text(
                                                      "${widget.data?.doctor?.fullName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16))),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "${widget.data?.doctor?.specialist}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Location",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Container(
                                                width: 180,
                                                child: Text(
                                                    "${widget.data?.hospital?.alamat}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Jumlah Pesakit",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text(
                                                  "${detailProvider.rowCount} Pesakit",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Batas Waktu",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text("${widget.data?.batch?.jam}",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Shipping Costs",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 7),
                                              Text(
                                                  "RM${widget.shipping.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 250,
                                      width: double.infinity,
                                      color: Color.fromRGBO(255, 184, 0, 1),
                                      child: Stack(
                                        children: [
                                          StreamBuilder(
                                            stream:
                                                Geolocator.getPositionStream(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              final position =
                                                  snapshot.data as Position;
                                              final myPosition = LatLng(
                                                  position.latitude,
                                                  position.longitude);
                                              final hospital = LatLng(
                                                  double.parse(
                                                      '${widget.data?.hospital?.latitude}'),
                                                  double.parse(
                                                      '${widget.data?.hospital?.longitude}'));
                                              detailProvider.getRoute(
                                                  myPosition, hospital);
                                              return FlutterMap(
                                                options: MapOptions(
                                                  center: hospital,
                                                  zoom: 15.0,
                                                ),
                                                nonRotatedChildren: [],
                                                children: [
                                                  TileLayer(
                                                    urlTemplate:
                                                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                    userAgentPackageName:
                                                        'com.example.app',
                                                    additionalOptions: {
                                                      'accessToken':
                                                          'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                      'id':
                                                          'mapbox/streets-v12',
                                                    },
                                                  ),
                                                  MarkerLayer(
                                                    markers: [
                                                      Marker(
                                                        point: hospital,
                                                        builder: (context) {
                                                          return Image.asset(
                                                              'assets/images/pin.png');
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailMapsPage(
                                                              latitude:
                                                                  double.parse(
                                                                      '${widget.data?.hospital?.latitude}'),
                                                              longitude:
                                                                  double.parse(
                                                                      '${widget.data?.hospital?.longitude}'),
                                                              jarak:
                                                                  widget.jarak,
                                                              waktu:
                                                                  widget.waktu,
                                                            )));
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 190,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${widget.data?.hospital?.rumahSakit}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 3),
                                                      Text(
                                                          "Lihat peta lebih besar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text("List Obat Pesakit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: detailProvider.isLoading
                                          ? (detailProvider.listPesakit == null
                                              ? Center(child: Text("No Data"))
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: detailProvider
                                                          .listPesakit
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      elevation: 3,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DetailObatPage(
                                                                            data:
                                                                                detailProvider.listPesakit?[index],
                                                                            statusBatch:
                                                                                widget.data?.statusBatch,
                                                                            shippingCost:
                                                                                widget.shipping,
                                                                            fileImage:
                                                                                null,
                                                                            batchId: widget.batchId,
                                                                          )));
                                                        },
                                                        title: Text(
                                                          detailProvider
                                                                  .listPesakit?[
                                                                      index]
                                                                  .pesakit
                                                                  ?.nama ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ))
                                          : CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: MaterialButton(
                              onPressed: () {},
                              minWidth: double.infinity,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide.none,
                              ),
                              color: Colors.grey,
                              child: Text(
                                "Waiting for Approve",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )));
                  },
                ),
              );
            }
            if (dataMap != null &&
                dataMap['status_batch'] == 'Take Medicine on Hospital') {
              return ChangeNotifierProvider(
                create: (context) => DetailCourierProvider(widget.batchId),
                child: Consumer<DetailCourierProvider>(
                  builder: (context, detailProvider, child) {
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
                        title: Center(
                            child: Text(
                          "Detail Task ${widget.data?.batch?.nama}",
                          style: TextStyle(color: Colors.black),
                        )),
                        actions: [
                          IconButton(
                              onPressed: () {
                                SideSheet.right(
                                    sheetColor: Colors.white,
                                    body: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 71, 255, 1),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(25),
                                                  bottomRight:
                                                      Radius.circular(25),
                                                )),
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.network(
                                                        "${ApiConfig.urlFoto}${dataGlobal.data?.user?.photo}"),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      dataGlobal.data?.user
                                                              ?.fullName ??
                                                          '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      "${dataGlobal.data?.user?.level}",
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .doc_append,
                                                          size: 28,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          "Job List",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text("99+")
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                WaitingConfirmedPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Waiting Confirmed",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TobePickUpPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "To Be Pick Up",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SedangKirimPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Sedang Dikirim",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ComplatePage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Complete",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HistoryCourierPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "History",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .doc_append,
                                                          size: 28,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          "Rejected",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    // Text("1"),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () async {
                                                    var prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.clear();
                                                    detailProvider
                                                        .logoutAuth(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.logout,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Logout",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    context: context);
                              },
                              icon: Icon(Icons.format_align_justify,
                                  color: Colors.black)),
                          SizedBox(width: 10),
                        ],
                      ),
                      body: RefreshIndicator(
                        onRefresh: () =>
                            detailProvider.refreshCourier(widget.data?.id),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        widget.data?.doctor?.photo == null
                                            ? CircularProgressIndicator()
                                            : Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: "${ApiConfig.urlFoto}${widget.data?.doctor?.photo}",
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                    errorWidget: (context, url, error) {
                                                      return ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Image.asset('assets/images/foto-profile.png'));
                                                    },
                                                  ),
                                                  // child: Image.network(
                                                  //   "${ApiConfig.urlFoto}${widget.data?.doctor?.profil}",
                                                  //   fit: BoxFit.cover,
                                                  //   errorBuilder: (context,
                                                  //       error, stackTrace) {
                                                  //     return CircularProgressIndicator();
                                                  //   },
                                                  // ),
                                                ),
                                              ),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 240,
                                                child: Text(
                                                    "${widget.data?.doctor?.fullName}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16))),
                                            const SizedBox(height: 5),
                                            Text(
                                                "${widget.data?.doctor?.specialist}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Location",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Container(
                                              width: 180,
                                              child: Text(
                                                  "${widget.data?.hospital?.alamat}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Jumlah Pesakit",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text(
                                                "${detailProvider.rowCount} Pesakit",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Batas Waktu",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text("${widget.data?.batch?.jam}",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Shipping Costs",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text(
                                                "RM${widget.shipping.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    color: Color.fromRGBO(255, 184, 0, 1),
                                    child: Stack(
                                      children: [
                                        StreamBuilder(
                                          stream:
                                              Geolocator.getPositionStream(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            final position =
                                                snapshot.data as Position;
                                            final myPosition = LatLng(
                                                position.latitude,
                                                position.longitude);
                                            final hospital = LatLng(
                                                double.parse(
                                                    '${widget.data?.hospital?.latitude}'),
                                                double.parse(
                                                    '${widget.data?.hospital?.longitude}'));
                                            detailProvider.getRoute(
                                                myPosition, hospital);
                                            return FlutterMap(
                                              options: MapOptions(
                                                center: hospital,
                                                zoom: 15.0,
                                              ),
                                              nonRotatedChildren: [],
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                  userAgentPackageName:
                                                      'com.example.app',
                                                  additionalOptions: {
                                                    'accessToken':
                                                        'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                    'id': 'mapbox/streets-v12',
                                                  },
                                                ),
                                                MarkerLayer(
                                                  markers: [
                                                    Marker(
                                                      point: hospital,
                                                      builder: (context) {
                                                        return Image.asset(
                                                            'assets/images/pin.png');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailMapsPage(
                                                            latitude: double.parse(
                                                                '${widget.data?.hospital?.latitude}'),
                                                            longitude: double.parse(
                                                                '${widget.data?.hospital?.longitude}'),
                                                            jarak: widget.jarak,
                                                            waktu: widget.waktu,
                                                          )));
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 190,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${widget.data?.hospital?.rumahSakit}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(height: 3),
                                                    Text(
                                                        "Lihat peta lebih besar",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text("List Obat Pesakit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: detailProvider.isLoading
                                        ? (detailProvider.listPesakit == null
                                            ? Center(child: Text("No Data"))
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: detailProvider
                                                        .listPesakit?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailObatPage(
                                                                          data:
                                                                              detailProvider.listPesakit?[index],
                                                                          statusBatch: widget
                                                                              .data
                                                                              ?.statusBatch,
                                                                          fileImage:
                                                                              null,
                                                                          shippingCost:
                                                                              widget.shipping,
                                                                          batchId: widget.batchId,
                                                                        )));
                                                      },
                                                      title: Text(
                                                        detailProvider
                                                                .listPesakit?[
                                                                    index]
                                                                .pesakit
                                                                ?.nama ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: Icon(
                                                        Icons.verified,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ))
                                        : CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottomNavigationBar: Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              height: 50,
                              minWidth: 170,
                              color: Color.fromRGBO(0, 71, 255, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Text("Status Update",
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.check_circle,
                                      color: Colors.white, size: 16)
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            MaterialButton(
                              onPressed: () {},
                              height: 50,
                              minWidth: 170,
                              color: Color.fromRGBO(43, 151, 32, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Text("Tracking Lane",
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.arrow_circle_right_rounded,
                                      color: Colors.white, size: 16)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            if (dataMap != null &&
                dataMap['status_batch'] == 'Sedang Dikirim') {
              return ChangeNotifierProvider(
                create: (context) => DetailCourierProvider(widget.batchId),
                child: Consumer<DetailCourierProvider>(
                  builder: (context, detailProvider, child) {
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
                        title: Center(
                            child: Text(
                              "Detail Task ${widget.data?.batch?.nama}",
                              style: TextStyle(color: Colors.black),
                            )),
                        actions: [
                          IconButton(
                              onPressed: () {
                                SideSheet.right(
                                    sheetColor: Colors.white,
                                    body: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 71, 255, 1),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(25),
                                                  bottomRight:
                                                  Radius.circular(25),
                                                )),
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.network(
                                                        "${ApiConfig.urlFoto}${dataGlobal.data?.user?.photo}"),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      dataGlobal.data?.user
                                                          ?.fullName ??
                                                          '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      "${dataGlobal.data?.user?.level}",
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .doc_append,
                                                          size: 28,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          "Job List",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Text("99+")
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                WaitingConfirmedPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Waiting Confirmed",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TobePickUpPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "To Be Pick Up",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SedangKirimPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Sedang Dikirim",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ComplatePage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Complete",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HistoryCourierPage()));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .doc_append,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "History",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .doc_append,
                                                          size: 28,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          "Rejected",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    // Text("1"),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () async {
                                                    var prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                    prefs.clear();
                                                    detailProvider
                                                        .logoutAuth(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.logout,
                                                            size: 28,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "Logout",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      // Text("1"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    context: context);
                              },
                              icon: Icon(Icons.format_align_justify,
                                  color: Colors.black)),
                          SizedBox(width: 10),
                        ],
                      ),
                      body: RefreshIndicator(
                        onRefresh: () =>
                            detailProvider.refreshCourier(widget.data?.id),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        widget.data?.doctor?.photo == null
                                            ? CircularProgressIndicator()
                                            : Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: "${ApiConfig.urlFoto}${widget.data?.doctor?.photo}",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) {
                                                return ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.asset('assets/images/foto-profile.png'));
                                              },
                                            ),
                                            // child: Image.network(
                                            //   "${ApiConfig.urlFoto}${widget.data?.doctor?.profil}",
                                            //   fit: BoxFit.cover,
                                            //   errorBuilder: (context,
                                            //       error, stackTrace) {
                                            //     return CircularProgressIndicator();
                                            //   },
                                            // ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 240,
                                                child: Text(
                                                    "${widget.data?.doctor?.fullName}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 16))),
                                            const SizedBox(height: 5),
                                            Text(
                                                "${widget.data?.doctor?.specialist}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Location",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Container(
                                              width: 180,
                                              child: Text(
                                                  "${widget.data?.hospital?.alamat}",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Jumlah Pesakit",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text(
                                                "${detailProvider.rowCount} Pesakit",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Batas Waktu",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text("${widget.data?.batch?.jam}",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Shipping Costs",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            SizedBox(height: 7),
                                            Text(
                                                "RM${widget.shipping.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    color: Color.fromRGBO(255, 184, 0, 1),
                                    child: Stack(
                                      children: [
                                        StreamBuilder(
                                          stream:
                                          Geolocator.getPositionStream(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                  CircularProgressIndicator());
                                            }
                                            final position =
                                            snapshot.data as Position;
                                            final myPosition = LatLng(
                                                position.latitude,
                                                position.longitude);
                                            final hospital = LatLng(
                                                double.parse(
                                                    '${widget.data?.hospital?.latitude}'),
                                                double.parse(
                                                    '${widget.data?.hospital?.longitude}'));
                                            detailProvider.getRoute(
                                                myPosition, hospital);
                                            return FlutterMap(
                                              options: MapOptions(
                                                center: hospital,
                                                zoom: 15.0,
                                              ),
                                              nonRotatedChildren: [],
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                  userAgentPackageName:
                                                  'com.example.app',
                                                  additionalOptions: {
                                                    'accessToken':
                                                    'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                                    'id': 'mapbox/streets-v12',
                                                  },
                                                ),
                                                MarkerLayer(
                                                  markers: [
                                                    Marker(
                                                      point: hospital,
                                                      builder: (context) {
                                                        return Image.asset(
                                                            'assets/images/pin.png');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailMapsPage(
                                                            latitude: double.parse(
                                                                '${widget.data?.hospital?.latitude}'),
                                                            longitude: double.parse(
                                                                '${widget.data?.hospital?.longitude}'),
                                                            jarak: widget.jarak,
                                                            waktu: widget.waktu,
                                                          )));
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 190,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${widget.data?.hospital?.rumahSakit}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)),
                                                    SizedBox(height: 3),
                                                    Text(
                                                        "Lihat peta lebih besar",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            decoration:
                                                            TextDecoration
                                                                .underline)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text("List Obat Pesakit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: detailProvider.isLoading
                                        ? (detailProvider.listPesakit == null
                                        ? Center(child: Text("No Data"))
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: detailProvider
                                          .listPesakit?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 3,
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          DetailObatPage(
                                                            data:
                                                            detailProvider.listPesakit?[index],
                                                            statusBatch: widget
                                                                .data
                                                                ?.statusBatch,
                                                            fileImage:
                                                            null,
                                                            shippingCost:
                                                            widget.shipping,
                                                            batchId: widget.batchId,
                                                          )));
                                            },
                                            title: Text(
                                              detailProvider
                                                  .listPesakit?[
                                              index]
                                                  .pesakit
                                                  ?.nama ??
                                                  '',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            trailing: Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                                        : CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottomNavigationBar: Padding(
                        padding:
                        EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              height: 50,
                              minWidth: 170,
                              color: Color.fromRGBO(0, 71, 255, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Text("Status Update",
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.check_circle,
                                      color: Colors.white, size: 16)
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            MaterialButton(
                              onPressed: () {},
                              height: 50,
                              minWidth: 170,
                              color: Color.fromRGBO(43, 151, 32, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Text("Tracking Lane",
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.arrow_circle_right_rounded,
                                      color: Colors.white, size: 16)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        }
        return SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
                child: CircularProgressIndicator())
            ));
      },
    );
  }
}
