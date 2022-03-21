import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/screen_category.dart';

import '../main.dart';

class Screen_transactions extends StatefulWidget {
  const Screen_transactions({Key? key}) : super(key: key);

  @override
  State<Screen_transactions> createState() => _Screen_transactionsState();
}

class _Screen_transactionsState extends State<Screen_transactions> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.yellow,
   
    );
  }
}
