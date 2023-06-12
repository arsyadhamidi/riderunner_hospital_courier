import 'package:flutter/material.dart';
import 'package:riderunner_hospital_courier/ui/modules/login_page/login_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

