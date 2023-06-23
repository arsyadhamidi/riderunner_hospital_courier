import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/detail_courier/detail_maps_provider.dart';

class DetailMapsPage extends StatelessWidget {

  final dynamic latitude;
  final dynamic longitude;

  DetailMapsPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

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
                            'https://api.mapbox.com/styles/v1/dzikrul1616/clf7lunv700co01mo8n22ee5m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZHppa3J1bDE2MTYiLCJhIjoiY2xleWJ6aTdlMGc0ODQxcXZsaDZlaDhwciJ9.Nz95V3UL1b8AfExigWUllA',
                            userAgentPackageName: 'com.example.app',
                            additionalOptions: {
                              'accessToken':
                              'pk.eyJ1IjoiZHppa3J1bDE2MTYiLCJhIjoiY2xleWJ6aTdlMGc0ODQxcXZsaDZlaDhwciJ9.Nz95V3UL1b8AfExigWUllA',
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
                                  return Image.asset(
                                      'assets/images/pin.png');
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
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.gps_fixed, color: Colors.black,)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
