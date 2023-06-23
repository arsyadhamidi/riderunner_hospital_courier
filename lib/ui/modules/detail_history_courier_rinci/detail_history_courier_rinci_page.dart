import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailHistoryCourierRinciPage extends StatelessWidget {
  const DetailHistoryCourierRinciPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
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
          "History Courier",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/foto-profile.png',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "Imam Taufiq Al-Haviz",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text("Diagnosis Penyakit")
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 12,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kota Kinabalu",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("Hospital"),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: 35,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(203, 158, 0, 1),
                                radius: 12,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bukit Jalil, Kuala Lumpur",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Container(
                                      width: 280,
                                      child: Text(
                                        "Jalan Barat, Bukit Jalil, 57000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.monetization_on,
                                          color: Colors.white),
                                      SizedBox(width: 5),
                                      Text("CASH",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text("Bukit Jalil, Kuala Lumpur",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Base Fare", style: TextStyle(color: Colors.blue)),
                              Text("RM 13.00", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add-on Change", style: TextStyle(color: Colors.blue)),
                              Text("RM 0.00", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 25),
                          DottedLine(),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Fare", style: TextStyle(color: Colors.blue)),
                              Text("RM 13.00", style: TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Commission", style: TextStyle(color: Colors.blue)),
                              Text("RM 2.60", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Sale", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                              Text("RM 10.40", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
