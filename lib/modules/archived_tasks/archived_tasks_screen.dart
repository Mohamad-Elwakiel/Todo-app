// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ArchivedTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Archived tasks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
        ),
      ),
    );
  }
}
