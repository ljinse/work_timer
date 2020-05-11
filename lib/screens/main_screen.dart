import 'package:flutter/material.dart';
import 'package:work_timer/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/models/work_data.dart';

class MainScreen extends StatelessWidget {
  runTimer(BuildContext context) {
    Provider.of<WorkData>(context).updateWorkState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkTimer'),
      ),
      body: Container(
        color:  Provider.of<WorkData>(context).workState ? Colors.lightBlueAccent : Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Provider.of<WorkData>(context).workState ? Icons.directions_run : Icons.airline_seat_legroom_extra,
                        size: 100.0,
                      ),
                      Text(
                        '00:00',
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    runTimer(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.lightBlue,
                child: FlatButton(
                  child: Text(
                    'FINISH',
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                  onPressed: () {
                    print(1);
                    Provider.of<WorkData>(context).updateTestData("main_data");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen()));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          for (int i = 0 ; i < Provider.of<WorkData>(context).count ; i ++)
                            Container(
                              child: SizedBox(
                                height: 10.0,
                                width: 10.0,
                              ),
                              color: i % 2 == 0 ? Colors.lightBlueAccent : Colors.grey,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.directions_run,
                                size: 30.0,
                              ),
                              Text(
                                '00:00',
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.airline_seat_legroom_extra,
                                  size: 30.0),
                              Text(
                                '00:00',
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
