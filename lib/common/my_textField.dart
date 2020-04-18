import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final Function onChanged;

  MyTextField({@required this.onChanged, this.label = ''});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label, style: TextStyle(color: Colors.teal, fontSize: 20)),
        TextFormField(
            style: TextStyle(fontSize: 25), onChanged: widget.onChanged),
        SizedBox(height: 20),
      ],
    );
  }
}
