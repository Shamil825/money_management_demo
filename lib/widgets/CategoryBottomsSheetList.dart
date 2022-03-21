import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';

class CategoryBottomsSheetList extends StatefulWidget {
  const CategoryBottomsSheetList({ Key? key }) : super(key: key);

  @override
  _CategoryBottomsSheetListState createState() => _CategoryBottomsSheetListState();
}

class _CategoryBottomsSheetListState extends State<CategoryBottomsSheetList> {
  late Box<ModelCode> boxhome;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
  }
  @override
  Widget build(BuildContext context) {
    return BottomSheet (
      
         onClosing: (){

         },
            builder: (BuildContext context) {
   
     return  ValueListenableBuilder(
                  valueListenable: boxhome.listenable(),
                  builder: (context, Box<ModelCode> homey, _) {
                     List<int> categorykey = homey.keys
                        .cast<int>()
                        .where(
                            (element) => boxhome.get(element)!.isExpense == true)
                        .toList();
                    List<int> expensekey = homey.keys
                        .cast<int>()
                        .where(
                            (element) => boxhome.get(element)!.isExpense == false)
                        .toList();
                    return ListView.separated(
    
                      itemBuilder: (context, index) {
                       
                        final int incomeData = categorykey[index];
                        final ModelCode? categorySelect = homey.get(incomeData);
    
                        return Card(
                          child: ListTile(
                            title: Text(categorySelect!.categoryname),
                          
                          
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount:categorykey .length,
                      shrinkWrap: true,
                    );
    
                  });
            }
    )
    ;
  }
}