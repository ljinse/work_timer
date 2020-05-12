import 'package:flutter/material.dart';
import 'package:work_timer/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/models/work_data.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Stopwatch watch = new Stopwatch();
  Timer timer;
  String elapsedTime = 'START';
  bool is_working = false;

  int workTime = 0;
  int restTime = 0;

  void startWatch() {
    setState(() {
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  void stopWatch() {
    setState(() {
      watch.stop();
      setTime();
    });
  }

  void setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar, false);
    });
  }

  void updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        //print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds, false);
      });
    }
  }

  void runTimer(BuildContext context) {
    Provider.of<WorkData>(context).updateWorkState();
  }

  void handleTap() {
    if (watch.isRunning) {
      stopWatch();
    }

    // reset
    setState(() {
      if (is_working) {
        workTime += watch.elapsedMilliseconds;
      } else {
        restTime += watch.elapsedMilliseconds;
      }
      is_working = !is_working;
    });

    watch.reset();

    //restart
    startWatch();
    print("startstop Inside=$is_working");
    elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds, false);

  }

  String transformMilliSeconds(int milliseconds, bool includeHours) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    //String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    if (includeHours) {
      return "$hoursStr:$minutesStr:$secondsStr";
    }
    return "$minutesStr:$secondsStr";
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
                        elapsedTime,
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    handleTap();
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
                          for (int i = 0 ; i < Provider.of<WorkData>(context).count -1 ; i ++)
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
                                transformMilliSeconds(workTime, true),
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
                                transformMilliSeconds(restTime, true),
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
