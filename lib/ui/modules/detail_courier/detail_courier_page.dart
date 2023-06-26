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
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/complete_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/sedang_kirim_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/tobe_pickup_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/waiting_confirmed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';

class DetailCourierPage extends StatefulWidget {
  final DataDokter? data;

  DetailCourierPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailCourierPage> createState() => _DetailCourierPageState();
}

class _DetailCourierPageState extends State<DetailCourierPage> {
  bool isApply = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailCourierProvider(widget.data?.id),
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
                "Detail Task ${widget.data?.nama}",
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
                                        child: Image.network(
                                            "${ApiConfig.urlFoto}${dataGlobal.data?.user?.profil}"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            dataGlobal.data?.user?.name ?? '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            "${dataGlobal.data?.user?.level}",
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
                                                size: 28,
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
                                          var prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.clear();
                                          detailProvider.logoutAuth(context);
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
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          widget.data?.profil == null
                              ? CircularProgressIndicator()
                              : Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${ApiConfig.urlFoto}${widget.data?.profil}",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 240,
                                  child: Text("${widget.data?.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))),
                              const SizedBox(height: 5),
                              Text("${widget.data?.specialist}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 7),
                              Container(
                                width: 180,
                                child: Text("${widget.data?.hospital?.alamat}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jumlah Pesakit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 7),
                              Text("5 Pesakit",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Batas Waktu",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 7),
                              Text("${widget.data?.jam}",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shipping Costs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(height: 7),
                              Text("RM 25",
                                  style: TextStyle(color: Colors.grey)),
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
                            stream: Geolocator.getPositionStream(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Center(child: CircularProgressIndicator());
                              }
                              final position = snapshot.data as Position;
                              final myPosition =
                                  LatLng(position.latitude, position.longitude);
                              final hospital = LatLng(
                                  double.parse(
                                      '${widget.data?.hospital?.latitude}'),
                                  double.parse(
                                      '${widget.data?.hospital?.longitude}'));
                              detailProvider.getRoute(myPosition, hospital);
                              return FlutterMap(
                                options: MapOptions(
                                  center: hospital,
                                  zoom: 15.0,
                                ),
                                nonRotatedChildren: [],
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://api.mapbox.com/styles/v1/dzikrul1616/clf7lunv700co01mo8n22ee5m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                                    userAgentPackageName: 'com.example.app',
                                    additionalOptions: {
                                      'accessToken':
                                          'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
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
                                        builder: (context) => DetailMapsPage(
                                              latitude: double.parse(
                                                  '${widget.data?.hospital?.latitude}'),
                                              longitude: double.parse(
                                                  '${widget.data?.hospital?.longitude}'),
                                            )));
                              },
                              child: Container(
                                height: 70,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Disini nama hospitalnya",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 3),
                                      Text("Lihat peta lebih besar",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline)),
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
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: detailProvider.isLoading
                          ? (detailProvider.listPesakit == null
                              ? Center(child: Text("No Data"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      detailProvider.listPesakit?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailObatPage(
                                                          data: detailProvider
                                                                  .listPesakit?[
                                                              index])));
                                        },
                                        title: Text(
                                          detailProvider.listPesakit?[index]
                                                  .pesakit?.nama ??
                                              '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: isApply == true
                                            ? Icon(Icons.arrow_forward_ios)
                                            : Icon(
                                                CupertinoIcons
                                                    .checkmark_seal_fill,
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
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are You Sure to Take this job ?",
                            textAlign: TextAlign.center),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text("Not Sure"),
                            ),
                            SizedBox(width: 20),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  isApply = !isApply;
                                });
                              },
                              elevation: 3,
                              color: Colors.blue,
                              height: 50,
                              minWidth: 120,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text("Of Course",
                                  style: TextStyle(color: Colors.white)),
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
                    side: BorderSide.none),
                color: isApply == true ? Colors.blue : Colors.grey,
                child: Text(
                  isApply == true ? "Apply This Job" : "Waiting for Approve",
                  style: TextStyle(
                      color: isApply == true ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
