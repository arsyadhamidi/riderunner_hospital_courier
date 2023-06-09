import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/detail_history_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/proof_page/proof_page_view.dart';

class DetailHistoryCourierPage extends StatefulWidget {
  const DetailHistoryCourierPage({Key? key}) : super(key: key);

  @override
  State<DetailHistoryCourierPage> createState() =>
      _DetailHistoryCourierPageState();
}

class _DetailHistoryCourierPageState extends State<DetailHistoryCourierPage> {
  @override
  void initState() {
    listDetailHistory?.toList(growable: true);
    super.initState();
  }

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
          "History Courier",
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
                MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey)),
                  child: Text("Filter"),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listDetailHistory?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                height: 45,
                                minWidth: 70,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text("Complete",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProofPage()));
                                    },
                                    height: 45,
                                    elevation: 3,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.file_copy, size: 20),
                                        SizedBox(width: 5),
                                        Text("Proof"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  MaterialButton(
                                    onPressed: () {},
                                    height: 45,
                                    elevation: 3,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.developer_board, size: 20),
                                        SizedBox(width: 5),
                                        Text("Medicine"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(height: 10),
                          Card(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(
                                    listDetailHistory?[index]
                                            .tglDetailHistory ??
                                        '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 25),
                                  Text(
                                    '${listDetailHistory?[index].jamHistory} - Obat Sampai Tujuan',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Imam Taufiq Al - Hafidz",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(CupertinoIcons.doc_append,
                                                  size: 20),
                                              SizedBox(width: 5),
                                              Text("Diagnosis Penyakit"),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.phone),
                                        SizedBox(width: 25),
                                        Text("(+60) 1234567890"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(width: 25),
                                        Container(
                                          width: 220,
                                            child: Text(
                                                "13, Jalan Kota Kecil, Bandar Kota Tinggi, 81900 Kota Tinggi, Johor, Malaysia")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Icon(CupertinoIcons.car),
                                        SizedBox(width: 25),
                                        Container(
                                            width: 220,
                                            child: Text(
                                                "RM 2")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
