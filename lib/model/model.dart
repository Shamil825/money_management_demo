
import 'package:hive/hive.dart';
 part 'model.g.dart';
@HiveType(typeId: 0)
class ModelCode {
  @HiveField(0)
  String categoryname;
  
  @HiveField(2)
 bool isExpense  ;

  ModelCode({required this.categoryname,required this.isExpense});
}
