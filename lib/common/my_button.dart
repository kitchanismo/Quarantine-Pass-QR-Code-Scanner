import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {this.text,
      this.onPressed,
      this.color = Colors.pinkAccent,
      this.isOutline = false});

  final isOutline;
  final onPressed;
  final color;
  final text;

  final padding = EdgeInsets.symmetric(vertical: 15, horizontal: 0);

  @override
  Widget build(BuildContext context) {
    if (isOutline) {
      return OutlineButton(
          onPressed: onPressed,
          color: color,
          borderSide: BorderSide(color: color),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: padding,
            child: Text(text, style: TextStyle(color: color, fontSize: 20)),
          ));
    }

    return FlatButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: padding,
          child:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
        ));
  }
}
