import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_history_courier/detail_history_courier_provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_history_courier_rinci/detail_history_courier_rinci_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/proof_page/proof_page_view.dart';

class DetailHistoryCourierPage extends StatefulWidget {

  final dynamic batchId;
  final dynamic tglPesakit;
  final dynamic jamPesakit;

  DetailHistoryCourierPage({Key? key, required this.batchId, required this.tglPesakit, required this.jamPesakit}) : super(key: key);

  @override
  State<DetailHistoryCourierPage> createState() =>
      _DetailHistoryCourierPageState();
}

class _DetailHistoryCourierPageState extends State<DetailHistoryCourierPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailHistoryCourierProvider(int.parse('${widget.batchId}')),
      child: Consumer<DetailHistoryCourierProvider>(
        builder: (context, detailHistory, child) {
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
            body: RefreshIndicator(
              onRefresh: () => detailHistory.refreshPesakit(int.parse('${widget.batchId}')),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Padding(
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
                            itemCount: detailHistory.listPesakit?.length ?? 0,
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
                                          minWidth: 50,
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
                                            Text('${widget.tglPesakit}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(width: 25),
                                            Text(
                                              '${widget.jamPesakit} - Obat Sampai Tujuan',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            DetailHistoryCourierRinciPage(
                                              nama: detailHistory.listPesakit?[index].pesakit?.nama,
                                              diagnosis: detailHistory.listPesakit?[index].pesakit?.diagnosis,
                                              alamat: detailHistory.listPesakit?[index].pesakit?.negeri,
                                              hospitalId: detailHistory.listPesakit?[index].pesakit?.hospitalId,
                                            )));
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.asset('assets/images/foto-profile.png', fit: BoxFit.cover,),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${detailHistory.listPesakit?[index].pesakit?.nama}",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 17)),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Icon(CupertinoIcons.doc_append,
                                                              size: 20),
                                                          SizedBox(width: 5),
                                                          Text("${detailHistory.listPesakit?[index].pesakit?.diagnosis}"),
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
                                                    Text("${detailHistory.listPesakit?[index].pesakit?.phoneNumber}"),
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
                                                            "${detailHistory.listPesakit?[index].pesakit?.negeri}, Kode Pos. ${detailHistory.listPesakit?[index].pesakit?.kodePos}")),
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
                                                            "RM2.00")),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
