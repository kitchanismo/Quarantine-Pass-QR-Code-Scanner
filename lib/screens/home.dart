import 'package:flutter/material.dart';
import 'package:qr_checker/common/my_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int ctr = 0;

  void doCount() async {
    int _ctr = await Future.delayed(Duration(seconds: 3), () {
      return 15;
    });
    setState(() {
      ctr = _ctr;
    });
  }

  // void didUpdateWidget() {

  // }

  void handleAdd() {
    setState(() {
      ctr++;
    });
  }

  navigateAbout() {
    Navigator.pushNamed(context, '/about');
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final borderRadius = BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20));

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Center(
            child: Text(
          'MOBILE QUEUEING',
          style: TextStyle(fontSize: 25),
        )),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 100, 90, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: MyButton(
                      text: 'SCAN',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: borderRadius, color: Colors.white),
                child: Column(
                  children: <Widget>[Text('ddd')],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
