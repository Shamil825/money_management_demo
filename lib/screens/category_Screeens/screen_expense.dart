
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/screen_category.dart';

class Screen_expense extends StatefulWidget {
  const Screen_expense({ Key? key,}) : super(key: key);

  @override
  State<Screen_expense> createState() => _Screen_expenseState();
}

class _Screen_expenseState extends State<Screen_expense> {

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
                 
                  List<int> expensekey = homey.keys
                      .cast<int>()
                      .where(
                          (element) => boxhome.get(element)!.isExpense == false)
                      .toList();
                  return ListView.separated(

                    itemBuilder: (context, index) {
                     
                      final int incomeData = expensekey[index];
                      final ModelCode? income = homey.get(incomeData);

                      return Card(
                        child: ListTile(
                          title: Text(income!.categoryname),
                          subtitle:
                              Text(income.isExpense ? "income" : "expense"),
                          trailing: Icon(Icons.circle,
                              color:
                                  income.isExpense ? Colors.green : Colors.red),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount:expensekey .length,
                    shrinkWrap: true,
                  );
                }); 
    }
}