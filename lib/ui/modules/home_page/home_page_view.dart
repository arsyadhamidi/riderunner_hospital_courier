import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_courier_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/history_courier/history_courier_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/home_page/home_page_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/profile_page/profile_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/complete_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/sedang_kirim_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/tobe_pickup_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/waiting_confirmed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool dateSearch = true;
  DateTime datePicked = DateTime.now();
  String date = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
      child: Consumer<HomePageProvider>(
        builder: (context, homeProvider, child) {
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
                                          homeProvider.logoutAuth(context);
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
              onRefresh: homeProvider.refreshR,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Card(
                        elevation: 3,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        child: TextFormField(
                          onChanged: (data) =>
                              homeProvider.filterPesakitList(data),
                          decoration: InputDecoration(
                              hintText: "Search Alamat terdekat, Rumah...",
                              suffixIcon: Icon(Icons.search),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide())),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  "${homeProvider.currentAddress}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                              );

                              if (newDate == null) return;

                              String day =
                                  newDate.day.toString().padLeft(2, '0');
                              String month =
                                  newDate.month.toString().padLeft(2, '0');
                              String year = newDate.year.toString();

                              setState(() {
                                dateSearch = !dateSearch;
                                date =
                                    "${newDate.day}/${newDate.month}/${newDate.year}";
                                homeProvider.isDateSearchTxt.text =
                                    "${newDate.day}/${newDate.month}/${newDate.year}";
                                homeProvider.filterTanggalDokterList(
                                    "${day}/${month}/${year}");
                              });
                            },
                            child: Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 71, 255, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    child: dateSearch
                                        ? Text(
                                            '${datePicked.day}/${datePicked.month}/${datePicked.year}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        : TextFormField(
                                            style:
                                                TextStyle(color: Colors.white),
                                            enabled: false,
                                            controller:
                                                homeProvider.isDateSearchTxt,
                                            onChanged: (value) => homeProvider
                                                .filterTanggalDokterList(value),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 18),
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                )),
                                          ),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      homeProvider.isLoading
                          ? ( homeProvider.filterDokterList?.length == 0
                              ? Center(child: Text('No Data'))
                              : ListView.builder(
                                  itemCount:
                                      homeProvider.filterDokterList?.length ??
                                          0,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailCourierPage(
                                                      data: homeProvider
                                                          .filterDokterList?[index],
                                                      shipping: homeProvider.travelCost,
                                                      jarak: homeProvider.distance,
                                                      waktu: homeProvider.travelTimeInMinutes,
                                                      batchId: homeProvider.filterDokterList?[index].id,
                                                    )));
                                      },
                                      child: Card(
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        elevation: 3,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        homeProvider
                                                                .filterDokterList?[
                                                                    index]
                                                                .tanggal ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Container(
                                                        height: 30,
                                                        width: 3,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        homeProvider
                                                                .filterDokterList?[
                                                                    index]
                                                                .jam ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          0, 71, 255, 1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                        homeProvider
                                                                .filterDokterList?[
                                                                    index]
                                                                .nama
                                                                .toString() ??
                                                            '',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                children: [
                                                  homeProvider
                                                              .listDokter?[
                                                                  index]
                                                              .profil !=
                                                          null
                                                      ? Container(
                                                          height: 50,
                                                          width: 50,
                                                          child: ClipRRect(
                                                            child:
                                                                Image.network(
                                                              "${ApiConfig.urlFoto}${homeProvider.filterDokterList?[index].profil}",
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Container(
                                                                    child: Image.asset(
                                                                        'assets/images/foto-profile.png',
                                                                        fit: BoxFit
                                                                            .cover),
                                                                    width: 50,
                                                                    height: 50);
                                                              },
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        )
                                                      : Container(
                                                          child: Image.asset(
                                                              'assets/images/foto-profile.png',
                                                              fit:
                                                                  BoxFit.cover),
                                                          width: 50,
                                                          height: 50),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${homeProvider.filterDokterList?[index].name.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${homeProvider.filterDokterList?[index].specialist}",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromRGBO(
                                                                203, 158, 0, 1),
                                                        child: Icon(
                                                          Icons
                                                              .local_hospital_rounded,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                        radius: 25,
                                                      ),
                                                      SizedBox(width: 15),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${homeProvider.filterDokterList?[index].hospital?.rumahSakit}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                              "Tempat Pengambilan Obat Untuk Pesakit",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey)),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom: 3,
                                                                      top: 3),
                                                                  child: Center(
                                                                    child: homeProvider.distance >= 100
                                                                        ? Text(
                                                                            '${homeProvider.distance.toStringAsFixed(0)} KM - ${homeProvider.travelTimeInMinutes} Minutes',
                                                                          )
                                                                        : Text(
                                                                            '${homeProvider.distance.toStringAsFixed(0)} KM - ${homeProvider.travelTime} Minutes',
                                                                          ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 48,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      100, 169, 0, 1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  )),
                                              child: Center(
                                                  child: Text(
                                                "RM${homeProvider.travelCost}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ))
                          : Text("No Data"),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
