// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Done tasks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
        ),
      ),
    );
  }
}
