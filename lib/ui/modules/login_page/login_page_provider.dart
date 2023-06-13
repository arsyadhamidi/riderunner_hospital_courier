import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riderunner_hospital_courier/api/api_config.dart';
import 'package:riderunner_hospital_courier/model/user_model.dart';
import 'package:riderunner_hospital_courier/ui/modules/home_page/home_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageProvider extends ChangeNotifier{

  String countryCode = '+60';
  bool isObsurce = true;
  TextEditingController isphoneNumberTxt = TextEditingController();
  TextEditingController isPasswordTxt = TextEditingController();

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
  
  Future<ModelUser?> loginAuth(BuildContext context) async{
    try{
      final response = await http.post(Uri.parse(ApiConfig.url + "api/login"), body: {
        'phone_number': countryCode+isphoneNumberTxt.text,
        'password': isPasswordTxt.text,
      });

      print(countryCode+isphoneNumberTxt.text);
      print(isPasswordTxt.text);

      ModelUser dataUser = modelUserFromJson(response.body);
      print('${dataUser.user?.name}, ${dataUser.user?.level}');

      if(dataUser.status == 'success'){
        await saveSharedPreference(dataUser);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePageView()), (route) => false);
        return dataUser;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Login Failed", style: TextStyle(color: Colors.white))));
      }
    }catch(e){
      print(e);
    }

  }


  Future<void> saveSharedPreference(ModelUser dataUser) async{
    SharedPreferences prefsUser = await SharedPreferences.getInstance();
    prefsUser.setString("dataUser", jsonEncode(dataUser));
  }


}