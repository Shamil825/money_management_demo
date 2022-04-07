import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_home.dart';
import 'package:money_management_flutter/screens/transaction.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart';

var sumExpense = 0;
var sumIncome=0;
class Screen_transactions extends StatefulWidget {
  const Screen_transactions({Key? key}) : super(key: key);

  @override
  State<Screen_transactions> createState() => _Screen_transactionsState();
}

class _Screen_transactionsState extends State<Screen_transactions> {
  late Box<TransactionModel>somubox;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  somubox = Hive.box(transactionBox);
    
  }
  //  var sumIncome = 0;


  void sumOfIncome() {
  sumIncome=0;
    var i = 0;

    List<int> incomekey =somubox.keys
        .cast<int>()
        .where((element) =>somubox.get(element)!.isIncome == true)
        .toList();
    for (i = 0; i < incomekey.length; i++) {
      final int data = incomekey[i];
      final TransactionModel? transaction =somubox.get(data);
      sumIncome = sumIncome + transaction!.AmountTransaction;
    }
  }
   void sumOfExpense() {
    sumExpense = 0;
    var i = 0;

    List<int> expensekey = somubox.keys
        .cast<int>()
        .where((element) => somubox.get(element)!.isIncome == false)
        .toList();
    for (i = 0; i < expensekey.length; i++) {
      final int data = expensekey[i];
      final TransactionModel? transaction = somubox.get(data);
      sumExpense = sumExpense + transaction!.AmountTransaction;
    }
    
  }


  @override
  Widget build(BuildContext context) {
   
    sumOfIncome();
    sumOfExpense();
    
    return Scaffold(
    backgroundColor: Color(hexcolor("CAF0F8")),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerbox) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(hexcolor("CAF0F8")),
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              title: const Center(
                heightFactor: 0,
                widthFactor: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "over view",
                    style: TextStyle(color:Colors.white),
                  ),
                ),
              ),
              background: Padding(
                padding: const EdgeInsets.all(8.0),
                
                child: Container(
                 
                  decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(hexcolor('48CAE4')),),
                  
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            
                            decoration: BoxDecoration(color: Color(hexcolor("38b000")),borderRadius: BorderRadius.all(Radius.circular(20))),
                            margin: const EdgeInsets.only(top: 10),
                            
                            height: 150,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(sumIncome.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            
                             decoration: BoxDecoration( color: Color(hexcolor("ba181b")),borderRadius: BorderRadius.all(Radius.circular(20))),
                            margin: const EdgeInsets.only(top: 10),
                            height: 150,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    sumExpense.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Total Income",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text("Total Expense",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: ValueListenableBuilder(
            valueListenable:somubox.listenable(),
            builder: (context, Box<TransactionModel> homey, _) {
              List<int> key = homey.keys.cast<int>().toList();
              return ListView.separated(
                itemBuilder: (context, index) {
                  final int data = key[index];
                  final TransactionModel? transaction = homey.get(data);

                  return Container(
                    height: 80,
                    child: Card(
                      color: Color(hexcolor('48CAE4')),
                      child: ListTile(
                        onLongPress: () {},
                        title: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                          
                          border:Border.all(color: Color(hexcolor('03045E'))
                          
                          )),
                          height: 60,
                          width: 60,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text(transaction!.date,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(hexcolor('023E8A')))),
                          )),
                       
                        trailing: Container(
                           padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                          
                     
                          ),

                    
                          width: 300,
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                               
                                  height: 20,
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        
                                 
                                       transaction.AmountTransaction.toString(),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Color(hexcolor("023E8A")),
                                             fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  )),
                              Container(
                                
                                height: 36,
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                       padding: EdgeInsets.only(right:14 ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                                        height: 30,
                                        width: 220,
                                        child: Column(
                                          children: [
                                           SizedBox(height: 10,),
                                            Text(transaction.selectedCategory,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,color: Color(hexcolor("023E8A")))),
                                          ],
                                        )),
                                    Container(
                                      height: 40,
                                      width: 80,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                deleteTransaction(index: index);
                                              },
                                              icon: Icon(Icons.delete)),
                                          Icon(Icons.circle,
                                              color: transaction.isIncome
                                                  ? Colors.green
                                                  : Colors.red),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: key.length,
                shrinkWrap: true,
              );
            }),
      ),
    );
  }

  deleteTransaction({required index}) {
  somubox.deleteAt(index);
    setState(() {});
  }
}
