import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_info.dart';
import 'package:money_management_flutter/screens/screen_transactions.dart';
import 'package:money_management_flutter/screens/transaction.dart';
import 'package:money_management_flutter/widgets/Calender.dart';
import 'package:money_management_flutter/widgets/add_button_Category.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:auto_reload/auto_reload.dart';

hexcolor (String colorhexcode){
  String colornew='0xff'+colorhexcode;
  colornew=colornew.replaceAll('#', '');
  int colorint=int.parse(colornew);
  return colorint;
}
int Selectedindex = 0;

class Screen_home extends StatefulWidget {
  const Screen_home({Key? key}) : super(key: key);

  @override
  State<Screen_home> createState() => _Screen_homeState();
}

class _Screen_homeState extends State<Screen_home> {
  static const List<Widget> _pages = [
    Screen_transactions(),
    Screem_category(),
  ];

  late Box<ModelCode> boxhome;
  

  var selectedCategoryTile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
    somubox = Hive.box(transactionBox);
  }
    

var screens=[Screen_transactions(),Screem_category()];
  var sumIncome = 0;

  @override
  Widget build(BuildContext context) {
    
    log("home builded");
    return SafeArea(
      
      child: Scaffold(
        
          appBar: AppBar(
            title: const Text("money management"),
            backgroundColor: Color(hexcolor('03045E')),
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey[300],
            child: ListView(
              children: [
                Container(
                  color: Color(hexcolor("03045E")),
                  height: 200,
                  child: ListTile(
                    tileColor: Colors.blue,
                    title: Text("More",style: TextStyle(color: Color(hexcolor("CAF0F8"))),),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                ListTile(
                  tileColor: Color(hexcolor("00B4D8")),
                  title: Text("Clear All Transactions "),
                  onTap: () {
                   
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen_home()))
                        .then((value) => setState(() {}));
                    somubox.clear();

                  },
                ),
                 SizedBox(
                  height: 2,
                ),
                 ListTile(
                  tileColor: Color(hexcolor("00B4D8")),
                  title: Text("Clear All Category "),
                  onTap: () {
                   
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen_home()))
                        .then((value) => setState(() {}));
boxhome.clear();
                  },
                ),
                SizedBox(
                  height: 2,
                ),
 ListTile(
                  tileColor: Color(hexcolor("00B4D8")),
                  title: Text("User"),
                  onTap: () {
                   
                   
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen_home()))
                        .then((value) => setState(() {}));

                  },
                ),
                SizedBox(
                  height: 2,
                ),

                ListTile(
                  tileColor: Color(hexcolor("00B4D8")),
                  title: Text("About "),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Screen_about()));
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
          
            backgroundColor: Color(hexcolor('03045E')),
            iconSize: 30,
            mouseCursor: SystemMouseCursors.wait,
            selectedFontSize: 25,
            unselectedIconTheme: IconThemeData(color: Colors.white),
            unselectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Color(hexcolor("ADE8F4")), size: 30),
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            currentIndex: Selectedindex,
            onTap: _onItemtapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ],
          ),
          floatingActionButton: 
          
          FloatingActionButton(
            
            onPressed: () {
              setState(() {
                if (Selectedindex == 0) {
                 
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Transaction()));
                  
                } else {
                  openDialogCategory(context);
                }
              });
            },
            child: Icon(Icons.add,),
            
            backgroundColor: Color(hexcolor('0096c7')),
            foregroundColor: Colors.white,
            
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Center(
            child: IndexedStack(index: Selectedindex, children: screens),
          )),
    );
  }

  void _onItemtapped(int index) {
    setState(() {
      Selectedindex = index;
    });
  }

  Future<void> openDialogCategory(BuildContext context) async {
    final _CategoryNameControlelr = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add category"),
            content: Column(children: [
              TextFormField(
                controller: _CategoryNameControlelr,
                autofocus: true,
                decoration:
                    InputDecoration(hintText: "enter the category name"),
              ),
            ]),
            actions: [
              TextButton(
                onPressed: () {
                  final String category = _CategoryNameControlelr.text;

                  ModelCode todo = ModelCode(
                    categoryname: category,
                    isExpense: changeindex == 0 ? true : false,
                  );
                  print(changeindex);

                  boxhome.add(todo);
Navigator.pushAndRemoveUntil<void>(
    context,
    MaterialPageRoute<void>(builder: (BuildContext context) => Screen_home()), (route) => false
    
  );
 
                  
                },
                child: const Text("Submit"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
            ],
          );
        });
  }
}
