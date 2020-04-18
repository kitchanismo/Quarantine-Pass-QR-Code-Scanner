import 'package:flutter/material.dart';
import 'package:qr_checker/screens/about.dart';
import 'package:qr_checker/screens/add.dart';
import 'package:qr_checker/screens/found_code.dart';
import 'package:qr_checker/screens/home.dart';
import 'package:qr_checker/screens/scanner.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/add': (context) => AddForm(),
        '/foundCode': (context) => FoundCode(),
        '/scanner': (context) => Scanner(title: 'Scanner'),
        '/about': (context) => About(title: 'Flutter Demo About Page'),
      },
    );
  }
}
