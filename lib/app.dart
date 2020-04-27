import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_checker/routes.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR SCANNER',
        theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'RobotoSlab'),
        initialRoute: initialRoute,
        routes: routes,
      ),
    );
  }
}
