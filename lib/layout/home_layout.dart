// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/components/components.dart';


Future<String> getName() async {
  return 'Mohamad Elwakiel';
}
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  IconData fabIcon = Icons.edit;
  int currentIndex = 0;
  List <Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List <String> title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
   late Database database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          title[currentIndex],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isBottomSheetShown){
            insertToDatabase(
              tittle: titleController.text,
              time: timeController.text,
              date: dateController.text,
            ).then((value){
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });




          } else {
            setState(() {
              fabIcon = Icons.add;
            });

            scaffoldKey.currentState!.showBottomSheet((context) =>
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(controller: titleController,
                            inputType: TextInputType.text,
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'title must not be empty';
                              }
                            },
                            text: 'Tittle',
                            prefixIcon: Icons.title
                        ),//title form field
                        //******//
                        SizedBox(
                          height: 10,
                        ),
                        //******//
                        defaultFormField(
                            controller: timeController,

                            inputType: TextInputType.datetime,
                            onTap: (){
                              showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                var formattedValue = value?.format(context).toString();
                                print(value?.format(context));
                                timeController.text = formattedValue!;
                              });
                            },
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'time must not be empty';
                              }
                            },
                            text: 'Time',
                            prefixIcon: Icons.watch_later_outlined), //Time Form filed
                        //******//
                        SizedBox(
                          height: 10,
                        ),
                        //******//
                        defaultFormField(controller: dateController,
                            inputType: TextInputType.datetime,
                            onTap: (){

                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2050-01-01'),
                            ).then((value){

                              print(DateFormat.yMMMd().format(value!));
                              var dateFormat = DateFormat.yMMMd().format(value);
                              dateController.text =  dateFormat;


                            });

                            },
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'Date must not be empty';
                              }
                            },
                            text: 'Date',
                            prefixIcon: Icons.calendar_today_outlined), //Date Form Field
                      ],

                    ),
                  ),
                ), elevation: 15.0);
            isBottomSheetShown = true;

          }

        },
        child: Icon(
            fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 150.0,
        backgroundColor: Colors.white60,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.check_box_outlined),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.archive_outlined),
            label: 'Archive',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
  void createDatabase() async {
       database = await openDatabase(
        'todod.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, tittle TEXT, date TEXT, time TEXT, status TEXT )').then((value){
            print('Table created');
          }).catchError((error){
            print('error detected');
          });
        },
        onOpen: (database){
          print('database opened');
    },
      );
  }

  Future insertToDatabase({required String tittle, required String time, required String date}) async {
    return await database.transaction((txn){
      return txn.rawInsert('INSERT INTO tasks(tittle, date, time, status) VALUES("$title","$time","$date","new")').then((value) {
        print('$value inserted into database');

      }).catchError((error){
        print('Error inserting record into databse ${error.toString()}');
      });

    });

  }
  }