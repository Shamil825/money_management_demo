
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_home.dart';

class Screen_income extends StatefulWidget {
  const Screen_income({ Key? key}) : super(key: key);

  @override
  State<Screen_income> createState() => _Screen_incomeState();
}

class _Screen_incomeState extends State<Screen_income> {
   late Box<ModelCode> boxhome;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
  }
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
                valueListenable: boxhome.listenable(),
                builder: (context, Box<ModelCode> homey, _) {
                   List<int> incomekey = homey.keys
                      .cast<int>()
                      .where(
                          (element) => boxhome.get(element)!.isExpense == true)
                      .toList();
                
                  return ListView.separated(

                    itemBuilder: (context, index) {
                     
                      final int incomeData = incomekey[index];
                      final ModelCode? income = homey.get(incomeData);

                      return Card(
                        child: Container(
                          color: Color(hexcolor("48CAE4")),
                          child: ListTile(
                            title: Text(income!.categoryname),
                            subtitle:
                                Text(income.isExpense ? "income" : "expense"),
                            trailing: Container(
                                             
                                              height: 40,
                                              width: 80,
                                              child: Row(
                                                
                                                children: [
                                                  IconButton(onPressed: (){
                                               boxhome.deleteAt(index);
                                                  

                                                    
                                            }, icon:Icon(Icons.delete) ),
                                            Icon(Icons.circle,
                                             color:
                                                 income.isExpense ? Colors.green : Colors.red),
                                                ],
                                              ),
                                            )
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 2,
                      );
                    },
                    itemCount:incomekey .length,
                    shrinkWrap: true,
                  );
                });
  }
}