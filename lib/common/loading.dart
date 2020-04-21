import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({
    Key key,
    @required this.child,
    this.isLoading = false,
  });

  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }
    return Stack(
      children: <Widget>[
        child,
        Scaffold(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
          body: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitChasingDots(
                color: Colors.pinkAccent,
                size: 70.0,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text('Please wait...', style: TextStyle(fontSize: 18))
            ],
          )),
        ),
      ],
    );
  }
}