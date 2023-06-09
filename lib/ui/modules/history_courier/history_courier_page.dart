import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/model/history_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_history_courier/detail_history_courier_page.dart';

class HistoryCourierPage extends StatefulWidget {
  const HistoryCourierPage({Key? key}) : super(key: key);

  @override
  State<HistoryCourierPage> createState() => _HistoryCourierPageState();
}

class _HistoryCourierPageState extends State<HistoryCourierPage> {
  @override
  void initState() {
    listHistory?.toList(growable: true);
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listHistory?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistoryCourierPage()));
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listHistory?[index].idHistory ?? '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 17),
                                          ),
                                          SizedBox(height: 5),
                                          Text("24 Mei 2023, 10:30 - 11:30", style: TextStyle(color: Color.fromRGBO(80, 80, 80, 1))),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          MaterialButton(
                                            onPressed: (){},
                                            height: 40,
                                            color: Colors.blue,
                                            minWidth: 70,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text("Task Complete", style: TextStyle(color: Colors.white),),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.withOpacity(0.2),
                                          radius: 30,
                                        ),
                                        SizedBox(height: 5),
                                        Text("Nama Doctor", style: TextStyle(fontWeight: FontWeight.w700),)
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
                                          Image.asset('assets/images/person.png', scale: 18),
                                        SizedBox(height: 10),
                                        Text("5 Pesakit", style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    SizedBox(width: 40),
                                    Column(
                                      children: [
                                        Image.asset('assets/images/drug.png', scale: 18),
                                        SizedBox(height: 10),
                                        Text("10 Obat", style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    SizedBox(width: 40),
                                    Column(
                                      children: [
                                        Image.asset('assets/images/location.png', scale: 18),
                                        SizedBox(height: 10),
                                        Text("5 Address", style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    SizedBox(width: 40),
                                    Column(
                                      children: [
                                        Image.asset('assets/images/cars.png', scale: 18),
                                        SizedBox(height: 10),
                                        Text("RM 25", style: TextStyle(fontSize: 12)),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
