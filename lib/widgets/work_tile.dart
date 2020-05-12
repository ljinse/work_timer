import 'package:flutter/material.dart';

class WorkTile extends StatelessWidget {

  WorkTile({@required this.icon, @required this.text, @required this.size});

  final IconData icon;
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: size,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size,
          ),
        ),
      ],
    );
  }
}