import 'package:f_sqflite1/add_user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQFLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddUserScreen(),
    );
  }
}
