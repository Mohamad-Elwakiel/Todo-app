// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'layout/home_layout.dart';

void main() {
  runApp(MyApp());
}
// wo main widgets : Stateless and Stateful

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),

    );
  }
}

