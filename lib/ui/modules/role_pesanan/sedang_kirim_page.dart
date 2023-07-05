import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/sedang_dikirim_provider.dart';

class SedangKirimPage extends StatefulWidget {
  const SedangKirimPage({Key? key}) : super(key: key);

  @override
  State<SedangKirimPage> createState() => _SedangKirimPageState();
}

class _SedangKirimPageState extends State<SedangKirimPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SedangDikirimProvider(),
      child: Consumer<SedangDikirimProvider>(
        builder: (context, dikirimProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_left_circle,
                    color: Colors.black,
                    size: 30,
                  )),
              title: Text(
                "Sedang Kirim",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('Orders_kkm')
                  .child('${dikirimProvider.token}')
                  .child('status_batch')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final statusBatch = snapshot.data!.snapshot.value;
                  print(statusBatch);
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: statusBatch == 'Sedang Dikirim'
                                ? Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      )),
                                ),
                                Container(
                                  height: 150,
                                  width: 330,
                                  decoration: BoxDecoration(
                                      color:
                                      Color.fromRGBO(217, 217, 217, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 140,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(50),
                                                      child: Image.network(
                                                        "${ApiConfig.urlFoto}${dikirimProvider.getDikirm?.profil}",
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (context, error,
                                                            stackTrace) {
                                                          return CircularProgressIndicator();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15),
                                                  child: Container(
                                                    width: 100,
                                                    child: Text(
                                                        "${dikirimProvider.getDikirm?.name}",
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                    "Driver Medicine",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        color:
                                                        Color.fromRGBO(
                                                            82,
                                                            82,
                                                            82,
                                                            1)),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                        Colors.blue,
                                                        radius: 5,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "Sedang Dikirim",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            color: Colors
                                                                .blue),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        Container(
                                          height: double.infinity,
                                          width: 2,
                                          color:
                                          Colors.black.withOpacity(0.2),
                                        ),
                                        Container(
                                            width: 140,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .calendar_month),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          "${dikirimProvider.getDikirm?.tanggal}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                              fontSize:
                                                              13)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      Icon(CupertinoIcons
                                                          .clock_fill),
                                                      SizedBox(width: 10),
                                                      Container(
                                                          width: 90,
                                                          child: Text(
                                                              "${dikirimProvider.getDikirm?.jam} - Harus ambil Medicine",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  13))),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      Icon(CupertinoIcons
                                                          .car),
                                                      SizedBox(width: 10),
                                                      Container(
                                                          width: 90,
                                                          child: Text(
                                                              "RM ${dikirimProvider.getDikirm?.cost}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  13))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Image.asset(
                                      'assets/images/empty.png'),
                                  SizedBox(height: 20),
                                  Text(
                                    "No Order Available",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            )
                        ]
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          );
        },
      ),
    );
  }
}
