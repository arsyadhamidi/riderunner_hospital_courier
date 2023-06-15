
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/ui/modules/home_page/home_page_view.dart';
import 'package:riderunner_hospital_courier/ui/modules/login_page/login_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider extends ChangeNotifier{

  SplashScreenProvider(BuildContext context){
    getSplash(context);
  }

  void getSplash(BuildContext context) async{

    Timer(Duration(seconds: 3), ()  async{
      var prefs = await SharedPreferences.getInstance();
      var data = prefs.get("dataUser");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => data != null ? HomePageView() : LoginPageView()), (route) => false);
    });

  }

}