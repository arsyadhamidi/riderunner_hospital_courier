import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/splashscreen_page/splashscreen_page_provider.dart';

class SplashScreenPageView extends StatelessWidget {
  const SplashScreenPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SplashScreenProvider(context),
      child: Consumer<SplashScreenProvider>(
        builder: (context, splashProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Spacer(),
                  Image.asset('assets/images/tasker.png'),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
