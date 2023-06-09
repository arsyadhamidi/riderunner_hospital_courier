import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/obat_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_page.dart';
import 'package:side_sheet/side_sheet.dart';

class DetailCourierPage extends StatefulWidget {
  const DetailCourierPage({Key? key}) : super(key: key);

  @override
  State<DetailCourierPage> createState() => _DetailCourierPageState();
}

class _DetailCourierPageState extends State<DetailCourierPage> {
  @override
  void initState() {
    listObat?.toList(growable: true);
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
          "Detail Task Batch 1",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 240,
                            child: const Text(
                                "Nama Doctor yang menyediakan Task ini",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                        const SizedBox(height: 5),
                        Text("Profesinya doctor disini",
                            style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 7),
                        Text("Rumah Sakit A - Farmasi",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jumlah Pesakit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 7),
                        Text("5 Pesakit", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Batas Waktu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 7),
                        Text("11:30", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shipping Costs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 7),
                        Text("RM 25", style: TextStyle(color: Colors.grey)),
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
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Disini nama hospitalnya",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Text("Lihat peta lebih besar",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Previous",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Next"),
                          SizedBox(width: 7),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("List Obat Pesakit",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are You Sure to Take this job ?", textAlign: TextAlign.center),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: (){},
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
                                onPressed: (){},
                                elevation: 3,
                                color: Colors.blue,
                                height: 50,
                                minWidth: 120,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text("Of Course", style: TextStyle(color: Colors.white)),
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
                  color: Colors.blue,
                  child: Text(
                    "Apply This Job",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listObat?.length,
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
                                  builder: (context) => DetailObatPage()));
                        },
                        title: Text(
                          listObat?[index].namaObat ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
