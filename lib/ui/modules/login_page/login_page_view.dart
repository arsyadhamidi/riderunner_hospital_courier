import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:riderunner_hospital_courier/ui/modules/login_page/login_page_provider.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginPageProvider(),
      child: Consumer<LoginPageProvider>(
        builder: (context, loginProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text("Login Account", style: TextStyle(color: Colors.black)),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Welcome Back!",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 28),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 34),
                        child: Text(
                          "Sign In to Continue",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(144, 144, 144, 1)),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: DropdownButton<String>(
                              value: loginProvider.countryCode,
                              onChanged: loginProvider.selectCountry,
                              underline: Container(),
                              items: [
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/indonesia.jpg'),
                                          ),
                                          SizedBox(width: 5),
                                          Text("+62", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                    ),
                                  value: '+62'
                                ),
                                DropdownMenuItem (
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage('assets/images/malaysia.jpg'),
                                        ),
                                        SizedBox(width: 5),
                                        Text("+60", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                  value: '+60',
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          hintText: "Phone number",
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: loginProvider.isObsurce,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(144, 144, 144, 1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          suffixIcon: IconButton(
                              onPressed: (){
                                loginProvider.inHidePassword();
                              },
                              icon: loginProvider.isObsurce ? Icon(CupertinoIcons.eye) : Icon(CupertinoIcons.eye_slash),
                          )
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){},
                              child: Text("Forgot Password ?"))
                        ],
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        onPressed: (){},
                        minWidth: double.infinity,
                        height: 48,
                        color: Color.fromRGBO(0, 71, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Sign In", style: GoogleFonts.inter(color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
