import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  MyButton(
      {@required this.child,
      this.onPressed,
      this.borderColor = Colors.pinkAccent,
      this.isOutline = false});
  final Widget child;
  final bool isOutline;
  final Function onPressed;
  final Color borderColor;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  final padding = EdgeInsets.fromLTRB(0, 15, 0, 15);

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
        disabledColor: Colors.grey,
        color: widget.borderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: padding,
          child: widget.child,
        ));
  }
}
