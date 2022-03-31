

import 'package:hive/hive.dart';
 part 'transactionModel.g.dart';

@HiveType(typeId: 1)
class TransactionModel {

@HiveField(0)
final bool isIncome;
@HiveField(1)

 final int AmountTransaction;
 @HiveField(2)
 final String ?notesTransaction;
 @HiveField(3)
 final String selectedCategory;
 @HiveField(4)
   var date;


  TransactionModel({
    required this.isIncome,
  required this.AmountTransaction,
   this.notesTransaction,
    required this.selectedCategory,
    required this.date,
  });
}
