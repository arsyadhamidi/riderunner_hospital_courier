import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TobePickUpPage extends StatefulWidget {
  const TobePickUpPage({Key? key}) : super(key: key);

  @override
  State<TobePickUpPage> createState() => _TobePickUpPageState();
}

class _TobePickUpPageState extends State<TobePickUpPage> {
  @override
  Widget build(BuildContext context) {
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
          "To Be Pick Up",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                    ),
                    Container(
                      height: 150,
                      width: 330,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(217, 217, 217, 1),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text("Nama Doctornya",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Driver Medicine",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color:
                                            Color.fromRGBO(82, 82, 82, 1)),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 5,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "To Be Pick Up",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700, color: Colors.red),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              height: double.infinity,
                              width: 2,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            Container(
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month),
                                          SizedBox(width: 10),
                                          Text("21 Maret 2023",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13)),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.clock_fill),
                                          SizedBox(width: 10),
                                          Container(
                                              width: 90,
                                              child: Text("10:30 - Harus ambil Medicine",
                                                  style: TextStyle(
                                                      fontSize: 13))),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.car),
                                          SizedBox(width: 10),
                                          Container(
                                              width: 90,
                                              child: Text("RM 20 - RM 30",
                                                  style: TextStyle(
                                                      fontSize: 13))),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
