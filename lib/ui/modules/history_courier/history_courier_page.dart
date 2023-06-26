import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/model/history_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_history_courier/detail_history_courier_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/history_courier/history_courier_provider.dart';

class HistoryCourierPage extends StatefulWidget {
  const HistoryCourierPage({Key? key}) : super(key: key);

  @override
  State<HistoryCourierPage> createState() => _HistoryCourierPageState();
}

class _HistoryCourierPageState extends State<HistoryCourierPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryCourierProvider(),
      child: Consumer<HistoryCourierProvider>(
        builder: (context, historyProvider, child) {
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
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Filter History")
                                    ],
                                  ),
                                );
                              },
                          );
                        },
                        minWidth: double.infinity,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey)),
                        child: Text("Filter"),
                      ),
                      SizedBox(height: 20),
                      historyProvider.isLoading
                          ? (historyProvider.listHistory == null
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: historyProvider.listHistory?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailHistoryCourierPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  historyProvider
                                                      .listHistory?[index]
                                                      .nama ??
                                                      '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                    "${historyProvider.listHistory?[index].tanggal} | ${historyProvider.listHistory?[index].jam}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            80, 80, 80, 1))),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                MaterialButton(
                                                  onPressed: () {},
                                                  height: 40,
                                                  color: Colors.blue,
                                                  minWidth: 70,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                  ),
                                                  child: Text(
                                                    "Task Complete",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    "${ApiConfig.urlFoto}${historyProvider.listHistory?[index].profil}",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child: Image.asset('assets/images/foto-profile.png'),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                  width: 100,
                                                  child: Text(
                                                    "${historyProvider.listHistory?[index].name}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w700),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/person.png',
                                                  scale: 18),
                                              SizedBox(height: 10),
                                              Text("5 Pesakit",
                                                  style:
                                                  TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(width: 40),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/drug.png',
                                                  scale: 18),
                                              SizedBox(height: 10),
                                              Text("10 Obat",
                                                  style:
                                                  TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(width: 40),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/location.png',
                                                  scale: 18),
                                              SizedBox(height: 10),
                                              Text("5 Address",
                                                  style:
                                                  TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(width: 40),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/cars.png',
                                                  scale: 18),
                                              SizedBox(height: 10),
                                              Text("RM 25",
                                                  style:
                                                  TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                          : Center(child: CircularProgressIndicator()),
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
