import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/model/delivery_model.dart';
import 'package:riderunner_hospital_courier/model/model_pesakit.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_obat/detail_obat_provider.dart';
import 'package:side_sheet/side_sheet.dart';

class DetailObatPage extends StatefulWidget {

  DataPesakit? data;

  DetailObatPage({Key? key, required this.data}) : super(key: key);

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
                      padding: EdgeInsets.all(20),
                      child: Text("This Assignment has not been Approved"),
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.data?.pesakit?.nama}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width: 300,
                                  child: Text("${widget.data?.pesakit?.negeri}, ${widget.data?.pesakit?.houseNumber}, Kode Pos : ${widget.data?.pesakit?.kodePos}")
                              ),
                              SizedBox(height: 5),
                              Text("Telp : ${widget.data?.pesakit?.phoneNumber}"),
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
                              child: Text("Medicine to be Delivered", style: TextStyle(color: Color.fromRGBO(0, 71, 255, 1), fontWeight: FontWeight.bold)),
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
                                        leading: Image.asset('assets/images/obat.png'),
                                        title: Text('${obat?.namaObat}'),
                                        trailing: Text('${obat?.jumlahObat}', style: TextStyle(fontWeight: FontWeight.bold),),
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
                                leading: Image.asset("assets/images/cost.png", scale: 10,),
                                title: Text("Cost Penghantaran", style: TextStyle(fontWeight: FontWeight.bold),),
                                trailing: Text("RM 2", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: ListTile(
                                leading: Icon(Icons.payments, size: 50,),
                                title: Text("Total Harga", style: TextStyle(fontWeight: FontWeight.bold),),
                                trailing: Text("RM ${widget.data?.totalHarga}", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
