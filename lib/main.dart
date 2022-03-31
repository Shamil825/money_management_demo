import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_home.dart';
import 'package:path_provider/path_provider.dart';


const String databoxname="databoxname";
const String transactionBox="transactionBox";
main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document=await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ModelCodeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
await Hive.openBox<ModelCode>(databoxname);
await Hive.openBox<TransactionModel>(transactionBox);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen_home(),
    );
  }
}