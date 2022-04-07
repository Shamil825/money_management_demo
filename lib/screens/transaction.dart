
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/model/transactionModel.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_home.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();

}

 late Box<TransactionModel> somubox;
 Box<ModelCode> boxhome=Hive.box(databoxname);


bool onPressedIncome = true;

class _TransactionState extends State<Transaction> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
    somubox = Hive.box(transactionBox);
    
    
  }

  var _selectedDateD;
  var _selectedDateM;
  var _selectedDate;
  int? SelectedDataTileIndexIncome;
  int? SelectedDataTileIndexExpense;

  int? SelectedExpenseTileIndex;
  var selectedCategoryTileIncome;
  var selectedCategoryTileExpense;

  final _AmountControlelr = TextEditingController();
  final _notesController = TextEditingController();

  int _Selectedindex = 0;
  bool _validate = false;
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDateD = DateFormat('dd').format(args.value);
    _selectedDateM = DateFormat('MMMM').format(args.value);
    _selectedDate = "$_selectedDateD\n\n $_selectedDateM";
    setState(() {});
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

  onCategoryPickedIncome({required index, required data}) {
    SelectedDataTileIndexIncome = index;
    selectedCategoryTileIncome = data!.categoryname;
    setState(() {});
  }

  onCategoryPickedExpense({required index, required data}) {
    SelectedDataTileIndexExpense = index;
    selectedCategoryTileExpense = data!.categoryname;
    setState(() {});
  }

  List<int> incomekey = boxhome.keys
      .cast<int>()
      .where((element) => boxhome.get(element)!.isExpense == true)
      .toList();

  List<int> expensekey = boxhome.keys
      .cast<int>()
      .where((element) => boxhome.get(element)!.isExpense == false)
      .toList();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(hexcolor("CAF0F8")),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  onPressedIncome == true
                                      ? Color(hexcolor("03045E"))
                                      : Colors.white)),
                          onPressed: () {
                            setState(() {});
                            onPressedIncome = true;
                          },
                          child: Text(
                            "Income",
                            style: onPressedIncome == true
                                ? TextStyle(color: Colors.white)
                                : TextStyle(color: Color(hexcolor("03045E"))),
                          )),
                      Container(
                        color: Color(hexcolor('CAF0F8')),
                        height: 50,
                        width: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                onPressedIncome == false
                                    ? Color(hexcolor("03045E"))
                                    : Colors.white)),
                        onPressed: () {
                          setState(() {});
                          onPressedIncome = false;
                        },
                        child: Text(
                          "Expense",
                          style: onPressedIncome == false
                              ? TextStyle(color: Colors.white)
                              : TextStyle(color: Color(hexcolor("03045E"))),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _AmountControlelr,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "enter the amount",
                      border: OutlineInputBorder()),
                  validator: (_AmountControlelr) =>
                      _AmountControlelr == null ? "enter amount" : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _notesController,
                  decoration: InputDecoration(
                    hintText: "notes",
                    border: OutlineInputBorder(),
                    errorText: _validate ? "Enter Note" : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                onPressedIncome == true
                    ? Container(
                        child: incomekey.isEmpty
                            ? TextButton(
                                onPressed: () {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen_home()));
                                 Selectedindex=1;
                                 changeindex=0;
                                }, 
                                child: Text("Create category"))
                            : TextButton.icon(
                                onPressed: () {
                                  setState(() {});
 FocusManager.instance.primaryFocus?.unfocus();
                                  showModalBottomSheet(
                                      enableDrag: false,
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                      context: context,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                            initialChildSize: 0.6,
                                            minChildSize: 0.5,
                                            maxChildSize: 0.6,
                                            builder: (_, controller) {
                                              return StatefulBuilder(
                                                builder: (context,
                                                        setState) =>
                                                    Container(
                                                        color: Colors.white,
                                                        padding:
                                                            EdgeInsets.all(
                                                                16),
                                                        child:
                                                            ValueListenableBuilder(
                                                                valueListenable:
                                                                    boxhome
                                                                        .listenable(),
                                                                builder: (context,
                                                                    Box<ModelCode>
                                                                        homey,
                                                                    _) {
                                                                  List<int> incomekey = homey
                                                                      .keys
                                                                      .cast<
                                                                          int>()
                                                                      .where((element) =>
                                                                          boxhome.get(element)!.isExpense ==
                                                                          true)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      print(
                                                                          onPressedIncome.toString());
                                                                      print(
                                                                          "Incommmmmmmm${incomekey.length}");

                                                                      final int
                                                                          incomeData =
                                                                          incomekey[index];
                                                                      final ModelCode?
                                                                          data =
                                                                          homey.get(incomeData);

                                                                      return Card(
                                                                        child:
                                                                            InkWell(
                                                                          splashColor: Colors.blue.withAlpha(30),
                                                                          child: ListTile(
                                                                            tileColor: SelectedDataTileIndexIncome == index ? Colors.blue : Colors.white,
                                                                            selectedTileColor: Colors.blue,
                                                                            hoverColor: Colors.blue[200],
                                                                            selected: index == SelectedDataTileIndexIncome,
                                                                            onTap: () {
                                                                              onCategoryPickedIncome(
                                                                                index: index,
                                                                                data: data,
                                                                              );
                                                                              Navigator.pop(context);
                                                                            },
                                                                            title: Text(
                                                                              data!.categoryname,
                                                                              style: TextStyle(
                                                                                color: SelectedDataTileIndexIncome == index ? Colors.white : Colors.red,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Divider();
                                                                    },
                                                                    itemCount:
                                                                        incomekey.length,
                                                                    shrinkWrap:
                                                                        true,
                                                                  );
                                                                })),
                                              );
                                            });
                                      });
                                },
                                icon: Icon(Icons.arrow_upward_outlined),
                                label: Text(
                                  selectedCategoryTileIncome == null
                                      ? "Select Category"
                                      : selectedCategoryTileIncome!,
                                  style: TextStyle(fontSize: 18),
                                )),
                      )
                    : Container(
                      
                        child: expensekey.length == 0 
                            ? TextButton(
                                onPressed: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen_home()));
                                 Selectedindex=1;
                                changeindex=1;
                                },
                                child: Text("Create category"))
                            : TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    FocusManager.instance.primaryFocus?.unfocus();
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
                                        return DraggableScrollableSheet(
                                            initialChildSize: 0.6,
                                            minChildSize: 0.5,
                                            maxChildSize: 0.6,
                                            builder: (_, controller) {
                                              return StatefulBuilder(
                                                builder: (context, setState) =>
                                                    Container(
                                                        color: Colors.white,
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        child:
                                                            ValueListenableBuilder(
                                                                valueListenable:
                                                                    boxhome
                                                                        .listenable(),
                                                                builder: (context,
                                                                    Box<ModelCode>
                                                                        homey,
                                                                    _) {
                                                                  List<int> expensekey = homey
                                                                      .keys
                                                                      .cast<
                                                                          int>()
                                                                      .where((element) =>
                                                                          boxhome
                                                                              .get(element)!
                                                                              .isExpense ==
                                                                          false)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      print(onPressedIncome
                                                                          .toString());
                                                                      print(
                                                                          "expeeeeeeeee${expensekey.length}");

                                                                      final int
                                                                          expenseData =
                                                                          expensekey[
                                                                              index];
                                                                      final ModelCode?
                                                                          data =
                                                                          homey.get(
                                                                              expenseData);

                                                                      return Card(
                                                                        child:
                                                                            InkWell(
                                                                          splashColor: Colors
                                                                              .blue
                                                                              .withAlpha(30),
                                                                          child:
                                                                              ListTile(
                                                                            tileColor: SelectedDataTileIndexExpense == index
                                                                                ? Colors.blue
                                                                                : Colors.white,
                                                                            selectedTileColor:
                                                                                Colors.blue,
                                                                            hoverColor:
                                                                                Colors.blue[200],
                                                                            selected:
                                                                                index == SelectedDataTileIndexExpense,
                                                                            onTap:
                                                                                () {
                                                                              onCategoryPickedExpense(
                                                                                index: index,
                                                                                data: data,
                                                                              );
                                                                              Navigator.pop(context);
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              data!.categoryname,
                                                                              style: TextStyle(
                                                                                color: SelectedDataTileIndexExpense == index ? Colors.white : Colors.red,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Divider();
                                                                    },
                                                                    itemCount:
                                                                        expensekey
                                                                            .length,
                                                                    shrinkWrap:
                                                                        true,
                                                                  );
                                                                })),
                                              );
                                            });
                                      });
                                },
                                icon: Icon(Icons.arrow_upward_outlined),
                                label: Text(
                                  selectedCategoryTileExpense == null
                                      ? "Select Category"
                                      : selectedCategoryTileExpense!,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                      ),
                Text(
                  _validate ? "Please Select Category" : "",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
                MaterialButton(
                  child: Container(
                    child: _selectedDateD == null
                        ? Text('Select a date')
                        : Text(_selectedDate!),
                  ),
                  onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
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

                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ));
                        });
                  },
                ),
                Text(
                  _validate ? "Please Select Date" : "",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {});

                      final String amount = _AmountControlelr.text;
                      final String notes = _notesController.text;
                      final String category = onPressedIncome == true
                          ? selectedCategoryTileIncome!
                          : selectedCategoryTileExpense!;
                      final String date = _selectedDate.toString();

                      TransactionModel todo = TransactionModel(
                          isIncome: onPressedIncome,
                          AmountTransaction: int.parse(amount),
                          notesTransaction: notes,
                          selectedCategory: category,
                          date: date);

                      _AmountControlelr.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _notesController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      selectedCategoryTileIncome != null
                          ? _validate = false
                          : _validate = true;
                      _selectedDate != null
                          ? _validate = false
                          : _validate = true;

                      somubox.add(todo);

                      selectedCategoryTileIncome = null;
                      selectedCategoryTileExpense = null;

                      final isValidform = formKey.currentState!.validate();
                      if (isValidform) {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen_home()))
                            .then((value) => setState(() {}));
                      }
                    },
                    child: Text("Add")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
