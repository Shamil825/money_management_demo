import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/category_Screeens/screen_expense.dart';
import 'package:money_management_flutter/screens/category_Screeens/screen_income.dart';

int? changeindex=0;
bool isIncomeScreen=true;
class Screem_category extends StatefulWidget {
  const Screem_category({Key? key}) : super(key: key);

  @override
  State<Screem_category> createState() => _Screem_categoryState();
}

class _Screem_categoryState extends State<Screem_category>
    with TickerProviderStateMixin {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
            TextButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(changeindex==0?Colors.blue:Colors.white)),
              onPressed: (){
              isIncomeScreen=true;
              setState(() {
                changeindex=0;
                
              });
            }, child:Text("income",style:changeindex==0 ?TextStyle(color: Colors.white):TextStyle(color: Colors.blue)),
            ),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(changeindex==1?Colors.blue:Colors.white)),
              onPressed: (){
              isIncomeScreen=false;
              setState(() {
                changeindex=1;
              });
            }, child: Text("expense",style:changeindex==1 ?TextStyle(color: Colors.white):TextStyle(color: Colors.blue))),
          ],),
          Expanded(
            child: isIncomeScreen==true?Screen_income():Screen_expense(),
            
            
            
            
            
            
            
            
           
          ),
        ],
      ),
    );
  }
}
