import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_history_courier/detail_history_courier_page.dart';
import 'package:riderunner_hospital_courier/ui/modules/history_courier/history_courier_provider.dart';

class HistoryCourierPage extends StatefulWidget {
  const HistoryCourierPage({Key? key}) : super(key: key);

  @override
  State<HistoryCourierPage> createState() => _HistoryCourierPageState();
}

class _HistoryCourierPageState extends State<HistoryCourierPage> {

  bool dateSearch = true;
  DateTime datePicked = DateTime.now();
  String date = "";

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
            body: RefreshIndicator(
              onRefresh: () => historyProvider.refreshHistory(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Card(
                            elevation: 3,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            child: TextFormField(
                              onChanged: (data) => historyProvider.filterPesakitList(data),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                    historyProvider.isDateSearchTxt.text =
                                    "${newDate.day}/${newDate.month}/${newDate.year}";
                                    historyProvider.filterTanggalDokterList(
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
                                          historyProvider.isDateSearchTxt,
                                          onChanged: (value) => historyProvider
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
                          historyProvider.isLoading
                              ? (historyProvider == null
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: historyProvider.filterHistoryList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailHistoryCourierPage(
                                                batchId: historyProvider.filterHistoryList?[index].id,
                                                tglPesakit: historyProvider.filterHistoryList?[index].batch?.tanggal,
                                                jamPesakit: historyProvider.filterHistoryList?[index].batch?.jam,)));
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
                                                          .filterHistoryList?[index]
                                                          .batch?.nama ??
                                                          '',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                        "${historyProvider.filterHistoryList?[index].batch?.tanggal} | ${historyProvider.filterHistoryList?[index].batch?.jam}",
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
                                                        "${ApiConfig.urlFoto}${historyProvider.filterHistoryList?[index].tasker?.profil}",
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
                                                        "${historyProvider.filterHistoryList?[index].doctor?.name}",
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
                                                  Text("${historyProvider.rowPesakit} Pesakit",
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
                                                  Text("${historyProvider.rowObat} Obat",
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
