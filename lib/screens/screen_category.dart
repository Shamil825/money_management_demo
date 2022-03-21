import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/category_Screeens/screen_expense.dart';
import 'package:money_management_flutter/screens/category_Screeens/screen_income.dart';

int? changeindex;

class Screem_category extends StatefulWidget {
  const Screem_category({Key? key}) : super(key: key);

  @override
  State<Screem_category> createState() => _Screem_categoryState();
}

class _Screem_categoryState extends State<Screem_category>
    with TickerProviderStateMixin {
  bool isIncomeScreen=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
            TextButton(onPressed: (){
              isIncomeScreen=true;
              setState(() {
                
              });
            }, child:Text("income"),
            ),
            TextButton(onPressed: (){
              isIncomeScreen=false;
              setState(() {
                
              });
            }, child: Text("expense")),
          ],),
          Expanded(
            child: isIncomeScreen==true?Screen_income():Screen_expense(),
            
            
            
            
            
            
            
            
           
          ),
        ],
      ),
    );
  }
}
