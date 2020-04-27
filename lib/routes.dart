import 'package:flutter/material.dart';
import 'package:qr_checker/screens/add.dart';
import 'package:qr_checker/screens/found.dart';
import 'package:qr_checker/screens/home.dart';
import 'package:qr_checker/screens/preview.dart';
import 'package:qr_checker/screens/scanner.dart';
import 'package:qr_checker/screens/signin.dart';
import 'package:qr_checker/screens/wrapper.dart';

String initialRoute = '/wrapper';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => Home(),
  '/wrapper': (context) => Wrapper(),
  '/preview': (context) => Preview(),
  '/add': (context) => AddForm(),
  '/signin': (context) => SignIn(),
  '/found': (context) => Found(),
  '/scanner': (context) => Scanner(title: 'Scanner'),
};
