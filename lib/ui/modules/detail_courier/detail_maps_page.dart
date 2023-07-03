import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_maps_provider.dart';

class DetailMapsPage extends StatelessWidget {

  final dynamic latitude;
  final dynamic longitude;
  final dynamic jarak;
  final dynamic waktu;

  DetailMapsPage({Key? key, required this.latitude, required this.longitude, required this.jarak, required this.waktu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailMapsProvider(),
      child: Consumer<DetailMapsProvider>(
        builder: (context, detailMapsProvider, child) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: Geolocator.getPositionStream(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      final position = snapshot.data as Position;
                      final myPosition =
                      LatLng(position.latitude, position.longitude);
                      final hospital = LatLng(
                          double.parse(
                              '${latitude}'),
                          double.parse(
                              '${longitude}'));
                      detailMapsProvider.getRoute(myPosition, hospital);
                      return FlutterMap(
                        options: MapOptions(
                          center: myPosition,
                          zoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                            userAgentPackageName: 'com.example.app',
                            additionalOptions: {
                              'accessToken':
                              'pk.eyJ1IjoidWRhY29kaW5nIiwiYSI6ImNrbGtwNjlxMDB0YjYycGx5bHc3NHg0b2sifQ.wCgrcy4tnqhPTAD9PVvypg',
                              'id': 'mapbox/streets-v12',
                            },
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: detailMapsProvider
                                    .routeCoords.isNotEmpty
                                    ? detailMapsProvider.routeCoords.last
                                    : myPosition,
                                builder: (context) {
                                  return Icon(Icons.location_on, color: Colors.red);
                                },
                              ),
                              Marker(
                                point: myPosition,
                                builder: (context) {
                                  return Image.asset(
                                      'assets/images/pin.png');
                                },
                              ),
                            ],
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                  color: Colors.blue,
                                  strokeWidth: 3.0,
                                  points: detailMapsProvider.routeCoords)
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_back, color: Colors.black,)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(20),
                            //   child: Row(
                            //     children: [
                            //       CircleAvatar(
                            //         backgroundColor: Colors.white,
                            //         child: IconButton(
                            //             onPressed: (){
                            //               detailMapsProvider.mapController.move(
                            //                   LatLng(double.parse('${detailMapsProvider.latitude}'), double.parse('${detailMapsProvider.longitude}')), detailMapsProvider.zoomIn);
                            //             },
                            //             icon: Icon(Icons.gps_fixed, color: Colors.black,)
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("${waktu}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                    SizedBox(width: 7),
                                    Text("(${jarak})", style: TextStyle(fontSize: 18, color: Colors.grey)),
                                    SizedBox(width: 7),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.amber
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Icon(CupertinoIcons.location_north_fill, size: 12),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text("Rute tercepat saat ini sesuai kondisi lalu lintas")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
