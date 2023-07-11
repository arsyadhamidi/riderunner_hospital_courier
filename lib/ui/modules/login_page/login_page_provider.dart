import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/conn/connectivity_check.dart';
import 'package:riderunner_hospital_courier/model/model_user.dart';
import 'package:riderunner_hospital_courier/ui/modules/home_page/home_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageProvider extends ChangeNotifier{

  String countryCode = '+60';
  bool isObsurce = true;
  TextEditingController isphoneNumberTxt = TextEditingController();
  TextEditingController isPasswordTxt = TextEditingController();
  String tokenNotif = '';

  LoginPageProvider(BuildContext context){
    Pushy.listen();
    Pushy.setNotificationIcon('ic_notification');
    pushyRegister(context);
    Pushy.toggleInAppBanner(true);
    Pushy.setNotificationListener(backgroundNotificationListener);
  }

  void selectCountry(value){
    countryCode = value;
    notifyListeners();
  }

  void inHidePassword(){
    if(isObsurce == true){
      isObsurce = false;
      notifyListeners();
    }else{
      isObsurce = true;
      notifyListeners();
    }
  }

  Future<void> updateToken(token) async{
    final response = await http.post(Uri.parse(ApiConfig.url + "api/notif-token"), body: {
      "firebase_notif_token": tokenNotif,
    }, headers: <String, String>{
          'Authorization': 'Bearer $token'
        });

    try{
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        notifyListeners();
        print('update token : ${response.statusCode}');
      } else {
        print('Error update token : ${response.statusCode}');
      }
    }catch(e){
      print(e);
    }

  }

  //pushy
  Future pushyRegister(context) async {
    try {
      // Register the user for push notifications
      String deviceToken = await Pushy.register();

      // Print token to console/logcat
      print('Device token: $deviceToken');
      tokenNotif = deviceToken;
      notifyListeners();
    } on PlatformException catch (error) {
      // Display an alert with the error message
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Error'),
                content: Text(error.message!),
                actions: [
                  ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      })
                ]);
          });
    }
  }

  void backgroundNotificationListener(Map<String, dynamic> data) {
    // Print notification payload data
    print('Received notification: $data');

    String notificationTitle = data['title'] ?? 'MyApp';
    String notificationText = data['message'] ?? 'Hello World!';
    Pushy.notify(notificationTitle, notificationText, data);

    // Clear iOS app badge number
    Pushy.clearBadge();
  }
  
  Future<ModelUser?> loginAuth(BuildContext context) async{
    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "api/login-kkm"), body: {
        'telp': countryCode+isphoneNumberTxt.text,
        'password': isPasswordTxt.text,
      });

      print(countryCode+isphoneNumberTxt.text);
      print(isPasswordTxt.text);

      ModelUser dataUser = modelUserFromJson(response.body);
      print('${dataUser.user?.fullName}, ${dataUser.user?.level}');

      final data = jsonDecode(response.body)['token'];

      if(dataUser.status == 'success'){
        SharedPreferences prefsUser = await SharedPreferences.getInstance();
        var dataPref = prefsUser.setString("dataUser", jsonEncode(dataUser));
        updateToken(data);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePageView()), (route) => false);
        return dataUser;
      }else{
        Fluttertoast.showToast(
          msg: "Number Phone and Password Wrong!",
          toastLength: Toast.LENGTH_SHORT, // Durasi toast (Toast.LENGTH_SHORT atau Toast.LENGTH_LONG)
          gravity: ToastGravity.BOTTOM, // Posisi toast (ToastGravity.TOP, ToastGravity.CENTER, atau ToastGravity.BOTTOM)
          timeInSecForIosWeb: 1, // Durasi toast untuk iOS dan web (dalam detik)
          backgroundColor: Colors.black54, // Warna latar belakang toast
          textColor: Colors.white, // Warna teks toast
          fontSize: 16.0, // Ukuran teks toast
        );
      }
    }catch(e){
      if (e is SocketException) {
        // Tidak ada koneksi jaringan
        ConnectivitCheck().showNoInternetConnection();
      } else if (e is HttpException) {
        // Server error
        ConnectivitCheck().showServerError();
      } else {
        // Tidak dapat terhubung
        ConnectivitCheck().showConnectionError();
      }
    }

  }



}