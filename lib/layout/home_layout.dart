// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, curly_braces_in_flow_control_structures

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../shared/components/constants.dart';



class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create : (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is InsertIntoDatabaseState)
            Navigator.pop(context);
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[300],
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text(
                cubit.title[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomSheetShown) {
                    cubit.insertToDatabase(
                      tittle: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                else {
                  // cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
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
                      ), elevation: 15.0
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(isShown: false, icon: Icons.edit);
                  });

                 cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
                }

              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 150.0,
              backgroundColor: Colors.white60,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
               cubit.changeIndex(index);
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
            body:  ConditionalBuilder(
              condition: state is! GetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}


