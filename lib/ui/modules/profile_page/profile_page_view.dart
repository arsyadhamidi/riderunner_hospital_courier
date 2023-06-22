import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/global/data_global.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 71, 255, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 71, 255, 1),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      )),
                ),
                dataGlobal.data?.user?.profil == null
                    ? Center(
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset('assets/image/foto-profile.png',
                              fit: BoxFit.cover),
                        ),
                    )
                    : Center(
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
                Padding(
                  padding: const EdgeInsets.only(top: 85),
                  child: Center(child: Text("${dataGlobal.data?.user?.name}", style: TextStyle(color: Colors.white, fontSize: 20),)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 115),
                  child: Center(
                    child: Text("${dataGlobal.data?.user?.level}", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${dataGlobal.data?.user?.name}"),
                    subtitle: Text("Tasker Name", style: TextStyle(fontStyle: FontStyle.italic),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.work),
                    title: Text("${dataGlobal.data?.user?.level}"),
                    subtitle: Text("Status", style: TextStyle(fontStyle: FontStyle.italic),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("${dataGlobal.data?.user?.phoneNumber}"),
                    subtitle: Text("Phone Number", style: TextStyle(fontStyle: FontStyle.italic),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
