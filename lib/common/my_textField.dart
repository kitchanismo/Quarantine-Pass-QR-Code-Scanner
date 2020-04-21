import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Text label;
  final Function onChanged;
  final Color textColor;
  final bool obscureText;
  final String initialValue;
  final bool readOnly;
  MyTextField(
      {@required this.onChanged,
      this.readOnly = false,
      this.label,
      this.textColor = Colors.teal,
      this.initialValue,
      this.obscureText = false});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.label,
        TextFormField(
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            obscureText: widget.obscureText,
            cursorColor: widget.textColor,
            style: TextStyle(fontSize: 25, color: widget.textColor),
            onChanged: widget.onChanged),
        SizedBox(height: 20),
      ],
    );
  }
}