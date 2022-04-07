import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management_flutter/screens/screen_home.dart';

class Screen_about extends StatelessWidget {
  const Screen_about({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      backgroundColor: Color(hexcolor("CAF0F8")),
      appBar:AppBar(
        backgroundColor: Color(hexcolor("03045E")),
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text("Vertion: 1.1.1.0"),
            SizedBox(height: 30,),
            Text("PublishedBy:Mohammed Shamil EK"),
          ],
        ),
      ),
    ));
  }
}