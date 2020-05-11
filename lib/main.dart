import 'package:flutter/material.dart';
import 'package:work_timer/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('WorkTimer'),
      ),
      body: MainScreen(),
    ));
  }
}
