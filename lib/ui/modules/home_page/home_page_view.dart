import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riderunner_hospital_courier/model/dokter_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_courier_page.dart';
import 'package:side_sheet/side_sheet.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  DateTime datePicked = DateTime.now();

  @override
  void initState() {
    listDokter?.toList(growable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
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
        title: Center(
            child: Text(
          "Courier Job List",
          style: TextStyle(color: Colors.black),
        )),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: TextStyle(color: Colors.white),
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
              icon: Icon(Icons.format_align_justify, color: Colors.black)),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search Alamat terdekat, Rumah...",
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide())),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        );
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
                            Center(
                              child: Text(
                                '${datePicked.day} ${DateFormat('MMMM').format(DateTime(datePicked.month))} ${datePicked.year}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: listDokter?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailCourierPage()));
                      },
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        elevation: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        listDokter?[index].tglDokter ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 30,
                                        width: 3,
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        listDokter?[index].jamDokter ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 71, 255, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                      )),
                                  child: Center(
                                    child: Text(listDokter?[index].idDokter ?? '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Doctor",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Speciallist Doctor",
                                        style: TextStyle(color: Colors.grey),
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
                                  left: 30, right: 20, top: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(144, 98, 98, 1),
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        radius: 25,
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Posisi anda saat ini",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text("Posisi anda saat ini",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 30,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 18),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Colors.black)
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Center(child: Text(listDokter?[index].jarakDokter ?? '')),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 30,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                        Color.fromRGBO(203, 158, 0, 1),
                                        child: Icon(
                                          Icons.local_hospital_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        radius: 25,
                                      ),
                                      SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${listDokter?[index].lokasiDokter}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text("Tempat Pengambilan Obat Untuk Pesakit",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
