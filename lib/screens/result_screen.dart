import 'package:flutter/material.dart';
import 'package:work_timer/models/work_data.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkTimer'),
      ),
      body: Container(
        color: Colors.orangeAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(Provider.of<WorkData>(context).testData),
          ],
        )
      ),
    );
  }
}
