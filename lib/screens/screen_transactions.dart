import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_home.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class Screen_transactions extends StatefulWidget {
  const Screen_transactions({Key? key}) : super(key: key);

  @override
  State<Screen_transactions> createState() => _Screen_transactionsState();
}

class _Screen_transactionsState extends State<Screen_transactions> {
  late Box<TransactionModel> boxhome;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(transactionBox);
    sumIncome;
  }
   var sumIncome = 0;


  void sumOfIncome() {
    sumIncome = 0;
    var i = 0;

    List<int> incomekey = boxhome.keys
        .cast<int>()
        .where((element) => boxhome.get(element)!.isIncome == true)
        .toList();
    for (i = 0; i < incomekey.length; i++) {
      final int data = incomekey[i];
      final TransactionModel? transaction = boxhome.get(data);
      sumIncome = sumIncome + transaction!.AmountTransaction;
    }
  }

  @override
  Widget build(BuildContext context) {
    sumOfIncome();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerbox) => [
          SliverAppBar(
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              title: const Center(
                heightFactor: 0,
                widthFactor: 2,
                child: Text(
                  "over view",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              background: Container(
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          color: Colors.green,
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
                          margin: EdgeInsets.only(top: 20),
                          color: Colors.red,
                          height: 150,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                sumExpense.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
        ],
        body: ValueListenableBuilder(
            valueListenable: boxhome.listenable(),
            builder: (context, Box<TransactionModel> homey, _) {
              List<int> key = homey.keys.cast<int>().toList();
              return ListView.separated(
                itemBuilder: (context, index) {
                  final int data = key[index];
                  final TransactionModel? transaction = homey.get(data);

                  return Container(
                    height: 80,
                    child: Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        onLongPress: () {},
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(transaction!.AmountTransaction.toString()),
                        ),
                        subtitle: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  transaction.isIncome ? "income " : "expense",
                                )),
                          ],
                        ),
                        trailing: Container(
                          width: 300,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 15,
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text("Notes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        transaction.date,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Container(
                                height: 40,
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        height: 500,
                                        width: 220,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  transaction.notesTransaction!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            Text(transaction.selectedCategory,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
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
    boxhome.deleteAt(index);
    setState(() {});
  }
}
