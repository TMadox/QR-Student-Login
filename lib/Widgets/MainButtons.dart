import 'dart:ui';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class FirstButtons extends StatelessWidget {
  String label;
  Function onpressed;
  Color color;
  IconData icon;
  Color labelcolor;
  Color iconcolor;
  FirstButtons(
      {@required this.label,
      @required this.onpressed,
      @required this.color,
      @required this.icon,
      @required this.labelcolor,
      @required this.iconcolor});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: onpressed,
        label: Text(
          label,
          style: TextStyle(color: labelcolor, fontWeight: FontWeight.bold),
        ),
        icon: Icon(
          icon,
          color: iconcolor,
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
      ),
    );
  }
}
