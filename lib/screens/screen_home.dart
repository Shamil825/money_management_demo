

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_transactions.dart';
import 'package:money_management_flutter/screens/transaction.dart';
import 'package:money_management_flutter/widgets/Calender.dart';
import 'package:money_management_flutter/widgets/add_button_Category.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:auto_reload/auto_reload.dart';



     var sumExpense = 0;
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
  late Box<TransactionModel>somubox;
  late int number;
  bool onPressedIncome=true;
  int ?SelectedDataTileIndex;
  
  int ?SelectedExpenseTileIndex;
  var selectedCategoryTile;


  int _Selectedindex = 0;
   bool _validate = false;

     var _selectedDate;

    

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
    somubox=Hive.box(transactionBox);
    print("object");
    
    
    
  }
   var sumIncome = 0;


  @override
  Widget build(BuildContext context) {
    sumOfIncome();  
    print("im here"); 
    
    return SafeArea(
      child: Scaffold(
       
          appBar: AppBar(
            title: Text("money management"),
           
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey[300],
          
            child: ListView(
              children: [
               Container(
                 height: 200,
                 child: ListTile(
                   
                   tileColor: Colors.blue,
                   title:Text("More"),
                 ),
               ),
              SizedBox(
                height: 3,
              ),
                ListTile(
                 tileColor: Colors.blue[100],
                 title:Text("Clear All "),
                 onTap: (){
                  
                 },
               ),
                 SizedBox(
                height: 1,
              ),
                ListTile(
                 tileColor: Colors.blue[100],
                 title:Text("info "),
               ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            iconSize: 30,
            mouseCursor: SystemMouseCursors.wait,
            selectedFontSize: 25,
            unselectedIconTheme: IconThemeData(color: Colors.white),
            unselectedItemColor: Colors.white,
            selectedIconTheme:
                IconThemeData(color: Colors.white, size: 30),
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            currentIndex: _Selectedindex,
            onTap: _onItemtapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_Selectedindex == 0) {
               
 Navigator.push(context, MaterialPageRoute(builder: (context)=>Transaction()))  ;                
                } else {
                 
                  openDialogCategory(context);
                }
              });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: _pages.elementAt(_Selectedindex),
          )),
    );
  }

  void _onItemtapped(int index) {
    setState(() {
      _Selectedindex = index;
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

                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
              TextButton(
                  onPressed: () {
                    cancel(context);
                  },
                  child: const Text("cancel")),
            ],
          );
        });
  }

  Future<void> openDialogTransaction(BuildContext context) async {
     
    final _AmountControlelr = TextEditingController();
    final _notesController=TextEditingController();
    

    return showDialog(
        context: context,
        builder: (context) {
       
          return StatefulBuilder(
            builder: (context,setState)=>
             SingleChildScrollView(
              child: AlertDialog(
                title: Text("Add Transaction"),
                content: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(onPressedIncome==true? Colors.blue:Colors.white)),
                              onPressed: () {
                                 setState(() {
                                 
                               });
                                onPressedIncome=true;
                              
                              },
                              child: Text(
                                "Income",
                                style:onPressedIncome==true? TextStyle( color: Colors.white):TextStyle(color: Colors.blue),
                              )),
                          Container(
                            color: Colors.white,
                            height: 50,
                            width: 5,
                          ),
                          TextButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(onPressedIncome==false? Colors.blue:Colors.white)),
                            onPressed: () {
                               setState(() {
                                 
                               });
                              onPressedIncome=false;
                             
                            },
                            child: Text(
                              "Expense",
                              style:onPressedIncome==false? TextStyle( color: Colors.white):TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (_AmountControlelr){
                       _AmountControlelr==null?"enter amount":null;
                      },
                      controller: _AmountControlelr,
                      keyboardType:TextInputType.number ,
                      decoration: InputDecoration(
                          hintText: "enter the amount",
                          errorText: _AmountControlelr==null?"enter":null,
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                          hintText: "notes", border: OutlineInputBorder(),
                            errorText: _validate? "Enter Note":null,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          TextButton.icon( onPressed: () {
                               setState(() {
                                 
                               });
                             
                                showModalBottomSheet(
                                  
                                    enableDrag: false,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    )),
                                    context: context,
                                    builder: (context) {
                              
                                      return buildSheet(context);
                                      
                                    });
                              }, icon: Icon(Icons.arrow_upward_outlined), label: Text(
 
                               selectedCategoryTile==null?"Select Category": selectedCategoryTile!,
                                style: TextStyle(fontSize: 18),
                              )),
                         
                         
                        ],
                      ),
                    ),
                    Text(_validate?"Please Select Category":"",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                  MaterialButton(
                  child: Container(
                    child: _selectedDate ==null
                ? Text('Select a date'):Text(_selectedDate!),
                  ),
                  onPressed: () {
                    setState(() {
                                 FocusScope.of(context).unfocus();
                               });
                    showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text(''),
                      content: Container(
                        height: 350,
                        child: Column(
                          children: <Widget>[
                            getDateRangePicker(),
                            MaterialButton(
                              child: Text("OK"),
                              onPressed: () {
                                  print(_selectedDate);
                                Navigator.pop(context);
                              
                                setState(() {
                                  
                                });
                              },
                            )
                          ],
                        ),
                      ));
                });
                  },
                ),
                  Text(_validate?"Please Select Date":"",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () {

                     setState(() {
                                 
                                });
                     
                   final String amount=_AmountControlelr.text;
                   final String notes=_notesController.text;
                   final String category=selectedCategoryTile!;
                   final String date=_selectedDate.toString();
          
                   TransactionModel todo=TransactionModel(isIncome:onPressedIncome , AmountTransaction:int.parse(amount), notesTransaction: notes, selectedCategory: category, date: date);
                  
           _AmountControlelr.text.isEmpty?_validate=true:_validate=false;
                      _notesController.text.isEmpty?_validate=true:_validate=false;
                      selectedCategoryTile!=null ?_validate=false:_validate=true;
                      _selectedDate!=null?_validate=false:_validate=true;
                  
                 
          
                    somubox.add(todo);

                    selectedCategoryTile="";
                   _validate==false? Navigator.pop(context):null;
                   
                   
               
          
                  }, child: Text("Add")),
                  TextButton(onPressed: () {
                   
                    Navigator.pop(context);
                                setState(() {
                                  
                                });
                  }, child: Text("Cancel")),
                ],
              ),
            ),
          );
        });
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }


  Widget buildSheet(BuildContext context) {
  
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.6,
        builder: (_, controller) {
          return StatefulBuilder(
            builder: (context,setState)=>
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: ValueListenableBuilder(
                  valueListenable: boxhome.listenable(),
                  builder: (context, Box<ModelCode> homey, _) {
                   List<int> incomekey = homey.keys
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
                       final int expenseData =expensekey[index];
                        final int incomeData = incomekey[index];
                        final ModelCode? data = homey.get(onPressedIncome==true ?incomeData:expenseData);
          
                        return Card(
                          
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                           
                            child: ListTile(
                              
                              tileColor: SelectedDataTileIndex==index?Colors.blue:Colors.white,
                              selectedTileColor: Colors.blue,
                                                 hoverColor: Colors.blue[200],
                              selected:index==SelectedDataTileIndex,
                               onTap: (){
                                
                                 
                                   SelectedDataTileIndex=index;
                                   selectedCategoryTile=data!.categoryname;
                                  setState(() {
                                    
                                 });

                                Navigator.pop(context);
                                 
                               },
                              title: Text(data!.categoryname,style: TextStyle(color:SelectedDataTileIndex==index?Colors.white:Colors.red,
                              ),),
                             
                            ),
                          ),
                          
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount:onPressedIncome==true?incomekey.length:expensekey.length,
                      shrinkWrap: true,
                    );
                  })),
          );
        });
  }
    

Widget getDateRangePicker() {
  return SizedBox(
      height: 250,
      width: 250,
      child: Card(
          child: SfDateRangePicker(
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.single,
        onSelectionChanged: selectionChanged,
      )));
}
void selectionChanged(DateRangePickerSelectionChangedArgs args) {
  _selectedDate = DateFormat('dd, MMMM, yyyy').format(args.value);
 setState(() {});
}

void sumOfIncome() {

 sumIncome=0;
    var i = 0;
   
  
   
  
   
     List<int> incomekey = somubox.keys
                        .cast<int>()
                        .where(
                            (element) => somubox.get(element)!.isIncome == true)
                        .toList(); 
                      


      for (i = 0; i < incomekey.length; i++) {
       
      final int data = incomekey[i];
      final TransactionModel? transaction = somubox.get(data);
     
      sumIncome=sumIncome+transaction!.AmountTransaction;

      setState(() {
        
      });
      
      }
    
  }
  void sumOfExpens() {
    var i = 0;
    
  
   
  
   
                          List<int> expensekey = somubox.keys
                        .cast<int>()
                        .where(
                            (element) => somubox.get(element)!.isIncome == false)
                        .toList();


      for (i = 0; i < expensekey.length; i++) {

      
         
      final int data = expensekey[i];
      final TransactionModel? transaction = somubox.get(data);
      
      sumExpense=sumExpense+transaction!.AmountTransaction;

      }
    
  }


  }


