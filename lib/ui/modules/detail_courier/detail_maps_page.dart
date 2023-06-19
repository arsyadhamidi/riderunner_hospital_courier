import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailMapsPage extends StatelessWidget {

  final dynamic latitude;
  final dynamic longitude;

  DetailMapsPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(double.parse('${latitude}'), double.parse('${longitude}')),
                zoom: 15.0,
              ),
              nonRotatedChildren: [

              ],
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
                      point: LatLng(double.parse('${latitude}'), double.parse('${longitude}')),
                      builder: (context) {
                        return Image.asset('assets/images/pin.png');
                      },
                    ),
                  ],
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
