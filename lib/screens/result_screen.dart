import 'package:flutter/material.dart';
import 'package:work_timer/widgets/work_tile.dart';

class ResultScreen extends StatelessWidget {
  final String workTimeStr;
  final String restTimeStr;
  final String totalTimeStr;

  ResultScreen({this.workTimeStr, this.restTimeStr, this.totalTimeStr});

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
            Expanded(
              child: Container(
                color: Colors.lightBlue,
                child: Center(
                  child: Text(
                    "RESULT",
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  WorkTile(
                    icon: Icons.directions_run,
                    text: workTimeStr,
                    size: 60.0,
                  ),
                  WorkTile(
                    icon: Icons.airline_seat_legroom_extra,
                    text: restTimeStr,
                    size: 60.0,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3.0,
                  ),
                  WorkTile(
                    icon: Icons.assistant_photo,
                    text: totalTimeStr,
                    size: 60.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FlatButton(
                color: Colors.lightBlueAccent,
                child: Text(
                  "RESET",
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
