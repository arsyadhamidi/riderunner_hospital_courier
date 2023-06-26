import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/ui/modules/role_pesanan/complete_provider.dart';

class ComplatePage extends StatefulWidget {
  const ComplatePage({Key? key}) : super(key: key);

  @override
  State<ComplatePage> createState() => _ComplatePageState();
}

class _ComplatePageState extends State<ComplatePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CompleteProvider(),
      child: Consumer<CompleteProvider>(
        builder: (context, completeProvider, child) {
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
                "Complete",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20,right: 20, bottom: 20),
                  child: completeProvider.isLoading
                      ? (completeProvider.listComplete == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    itemCount: completeProvider.listComplete?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 150,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green,
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
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    "${ApiConfig.urlFoto}${completeProvider.listComplete?[index].profil}",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return CircularProgressIndicator();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Container(
                                                width: 100,
                                                child: Text("${completeProvider.listComplete?[index].name}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                    backgroundColor: Colors.green,
                                                    radius: 5,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Complete",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700, color: Colors.green),
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
                                                  Text("${completeProvider.listComplete?[index].tanggal}",
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
                                                      child: Text("${completeProvider.listComplete?[index].jam} - Harus ambil Medicine",
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
                        ),
                      );
                    },
                  ))
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
