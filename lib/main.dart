import 'package:flutter/material.dart';
import 'package:manage_expense/screens/login.dart';
import 'package:manage_expense/screens/home.dart';
import 'package:manage_expense/screens/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Login(),
         '/HomePage': (context) => HomePage(),
      
      },
      
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
