import 'package:flutter/material.dart';

class FoundCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(appBar: AppBar(title: Text(data['code'])));
  }
}
