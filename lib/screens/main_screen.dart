import 'package:flutter/material.dart';
import 'package:work_timer/screens/result_screen.dart';
import 'dart:async';
import 'package:work_timer/widgets/work_tile.dart';
import 'dart:ui';


class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  double blockWidthForOneMin = window.physicalSize.width / (60 * 60 * 2); // max : 2H

  bool isWorking = false;

  int totalWorkTime = 0;
  int totalRestTime = 0;
  List<int> timeList = [];

  Stopwatch watch = new Stopwatch();
  Timer timer;
  String elapsedTime = 'START';

  void resetData() {
    isWorking = false;
    totalWorkTime = 0;
    totalRestTime = 0;
    timeList.clear();
    elapsedTime = 'START';

    watch = new Stopwatch();
  }

  void resetAndStartWatch() {
    watch.reset();
    watch.start();
    Timer.periodic(Duration(milliseconds: 100), updateTime);
  }

  void stopWatch() {
    watch.stop();
  }

  void updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds, false);
      });
    }
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

  void handleTap() {
    if (watch.isRunning) {
      stopWatch();
    }

    // reset
    setState(() {
      int time = watch.elapsedMilliseconds;
      if (isWorking) {
        totalWorkTime += time;
      } else {
        totalRestTime += time;
      }
      isWorking = !isWorking;
      timeList.add(time);
    });
    resetAndStartWatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkTimer'),
      ),
      body: Container(
        color: isWorking
            ? Colors.lightBlueAccent
            : Colors.grey,
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
                       isWorking
                            ? Icons.directions_run
                            : Icons.airline_seat_legroom_extra,
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
                  onTap: handleTap,
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
                          for (int i = 0; i < timeList.length ; i++)
                            Container(
                              child: SizedBox(
                                height: 20.0,
                                width: blockWidthForOneMin * timeList[i] / 1000,
                              ),
                              color: i % 2 == 0
                                  ? Colors.lightBlueAccent
                                  : Colors.grey,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          WorkTile(
                            icon: Icons.directions_run,
                            text: transformMilliSeconds(totalWorkTime, true),
                            size: 30.0,
                          ),
                          WorkTile(
                            icon: Icons.airline_seat_legroom_extra,
                            text: transformMilliSeconds(totalRestTime, true),
                            size: 30.0,
                          ),
                        ],
                      ),
                    )
                  ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          workTimeStr: transformMilliSeconds(totalWorkTime, true),
                          restTimeStr: transformMilliSeconds(totalRestTime, true),
                          totalTimeStr: transformMilliSeconds(totalWorkTime + totalRestTime, true),
                        ),
                      ),
                    );

                    resetData();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
