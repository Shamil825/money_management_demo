import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_flutter/main.dart';
import 'package:money_management_flutter/model/model.dart';
import 'package:money_management_flutter/screens/screen_category.dart';
import 'package:money_management_flutter/screens/screen_transactions.dart';
import 'package:money_management_flutter/widgets/add_button_Category.dart';
import 'package:money_management_flutter/widgets/CategoryBottomsSheetList.dart';

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
  late int number;

  int _Selectedindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxhome = Hive.box(databoxname);
    number = 56;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("money management"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            iconSize: 30,
            mouseCursor: SystemMouseCursors.wait,
            selectedFontSize: 25,
            unselectedIconTheme: IconThemeData(color: Colors.white),
            unselectedItemColor: Colors.white,
            selectedIconTheme:
                IconThemeData(color: Colors.amberAccent, size: 30),
            selectedItemColor: Colors.amberAccent,
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
                  openDialogTransaction(context);
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
    final _CategoryNameControlelr = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Transaction"),
            content: Column(
              children: [
                Container(
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Income",
                            style: TextStyle(color: Colors.black),
                          )),
                      Container(
                        color: Colors.white,
                        height: 50,
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Expense",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "enter the amount",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "notes", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                  CategoryBottomsSheetList();
                          },
                          child: Text(
                            "Select Category",
                            style: TextStyle(fontSize: 18),
                          )),
                      Icon(
                        Icons.arrow_upward_outlined,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text("Add")),
              TextButton(onPressed: () {}, child: Text("Cancel")),
            ],
          );
        });
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }
}
