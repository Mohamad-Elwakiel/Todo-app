// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'New tasks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
        ),
      ),
    );
  }
}
