import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 71, 255, 1),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      )),
                ),
                dataGlobal.data?.user?.profil == null
                    ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset('assets/image/foto-profile.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.network(
                              "${ApiConfig.urlFoto}${dataGlobal.data?.user?.profil}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                      child: Text(
                    "${dataGlobal.data?.user?.name}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 130),
                  child: Center(
                    child: Text("Current Credit",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(
                    child: Text(
                      "RM 0.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${dataGlobal.data?.user?.name}"),
                    subtitle: Text(
                      "Tasker Name",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.work),
                    title: Text("${dataGlobal.data?.user?.level}"),
                    subtitle: Text(
                      "Status",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("${dataGlobal.data?.user?.phoneNumber}"),
                    subtitle: Text(
                      "Phone Number",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          minWidth: double.infinity,
          height: 48,
          color: Color.fromRGBO(0, 71, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("Back", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
