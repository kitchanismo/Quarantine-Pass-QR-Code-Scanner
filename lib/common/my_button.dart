import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  MyButton(
      {@required this.child,
      this.text,
      this.onPressed,
      this.borderColor = Colors.pinkAccent,
      this.isOutline = false});
  final Widget child;
  final isOutline;
  final onPressed;
  final borderColor;
  final text;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  final padding = EdgeInsets.symmetric(vertical: 15, horizontal: 0);

  @override
  Widget build(BuildContext context) {
    if (widget.isOutline) {
      return OutlineButton(
          onPressed: widget.onPressed,
          color: widget.borderColor,
          borderSide: BorderSide(color: widget.borderColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: padding,
            child: widget.child,
          ));
    }

    return FlatButton(
        onPressed: widget.onPressed,
        color: widget.borderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: padding,
          child: widget.child,
        ));
  }
}
