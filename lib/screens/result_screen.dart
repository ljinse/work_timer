import 'package:flutter/material.dart';
import 'package:work_timer/models/work_data.dart';
import 'package:provider/provider.dart';
import 'package:work_timer/widgets/work_tile.dart';

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
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              WorkTile(
                icon: Icons.directions_run,
                text: '00:00',
                size: 80.0,
              ),
              WorkTile(
                icon: Icons.airline_seat_legroom_extra,
                text: '00:00',
                size: 80.0,
              ),
              Divider(color: Colors.black,
              thickness: 3.0,),

              WorkTile(
                icon: Icons.assistant_photo,
                text: '00:00',
                size: 80.0,
              ),
            ],
          )),
    );
  }
}
