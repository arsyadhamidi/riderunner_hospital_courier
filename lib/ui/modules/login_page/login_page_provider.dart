import 'package:flutter/material.dart';

class LoginPageProvider extends ChangeNotifier{

  String countryCode = '+60';
  bool isObsurce = true;

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

}