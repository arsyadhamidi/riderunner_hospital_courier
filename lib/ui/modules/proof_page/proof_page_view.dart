import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProofPage extends StatefulWidget {
  const ProofPage({Key? key}) : super(key: key);

  @override
  State<ProofPage> createState() => _ProofPageState();
}

class _ProofPageState extends State<ProofPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.arrow_left_circle,
                color: Colors.black,
                size: 30,
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Column(
              children: [
                Text("Batch 1", style: TextStyle(color: Colors.black)),
                Text(
                  "Imam Taufik Al-Hafidz",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: 450,
                color: Colors.red,
              ),
              SizedBox(height: 15),
              Text("1 / 2", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: 100,
                    color: Colors.grey.withOpacity(0.2),
                    elevation: 0,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey,),
                        Text("Previous", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  MaterialButton(
                    onPressed: (){},
                    minWidth: 100,
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text("Next", style: TextStyle(color: Colors.grey)),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: (){},
          height: 50,
          minWidth: double.infinity,
          color: Colors.blue,
          child: Text("Download", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
