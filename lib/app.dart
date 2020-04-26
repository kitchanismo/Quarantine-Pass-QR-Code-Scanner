import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:qr_checker/screens/add.dart';
import 'package:qr_checker/screens/found.dart';
import 'package:qr_checker/screens/home.dart';
import 'package:qr_checker/screens/preview.dart';
import 'package:qr_checker/screens/scanner.dart';
import 'package:qr_checker/screens/signin.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Baloo'),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/preview': (context) => Preview(),
          '/add': (context) => AddForm(),
          '/signin': (context) => SignIn(),
          '/found': (context) => Found(),
          '/scanner': (context) => Scanner(title: 'Scanner'),
        },
      ),
    );
  }
}
