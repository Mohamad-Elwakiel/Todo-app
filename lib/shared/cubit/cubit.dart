import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';

class AppCubit extends Cubit <AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
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
  void changeIndex (int index){
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
  late Database database;
  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> archivedTasks = [];
  void createDatabase() {
      openDatabase(
      'todo1.db',
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
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  void updateData({required String status, required int id}) async {

     database.rawUpdate(
        'UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDatabase(database);
          emit(UpdateDatabaseState());

     });


  }

  void deleteData({required int id}) async {

    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]).then((value) {
      getDataFromDatabase(database);
      emit(DeleteItemFromDatabaseState());

    });


  }

   insertToDatabase({required String tittle, required String time, required String date}) async {
    return await database.transaction((txn){
      return txn.rawInsert('INSERT INTO tasks(tittle, date, time, status) VALUES("$tittle","$date","$time","new")').then((value) {
        print('$value inserted into database');
        emit(InsertIntoDatabaseState());
        getDataFromDatabase(database);

      }).catchError((error){
        print('Error inserting record into database ${error.toString()}');
      });

    });

  }
  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(GetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element) {
        if(element['status'] == 'new')
          {
            newTasks.add(element);
          }
        else if (element['status'] == 'done')
          {
            doneTasks.add(element);
          }
        else
          {
            archivedTasks.add(element);
          }
          
        
      });
      emit(GetFromDatabaseState());
    });


  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;
void changeBottomSheetState({
  required bool isShown,
  required IconData icon,
})
{
  isBottomSheetShown = isShown;
  fabIcon = icon;
  emit(ChangeBottomSheetState());

}
}
