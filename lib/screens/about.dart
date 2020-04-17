import 'package:flutter/material.dart';

class About extends StatelessWidget {
  About({this.title});
  final title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
    );
  }
}
