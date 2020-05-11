import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/models/work_data.dart';
import 'package:work_timer/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => WorkData(),
      child: MaterialApp(
          home: MainScreen(),
      ),
    );
  }
}
