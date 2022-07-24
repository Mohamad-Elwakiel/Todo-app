// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) => buildTaskItem(tasks[index]), separatorBuilder: (context, index) => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ), itemCount: tasks.length);
  }
}
