import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  final List<Widget> list;
  final Widget child;
  MyList({@required this.list, @required this.child});
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, i) {
          return widget.child;
        });
  }
}
