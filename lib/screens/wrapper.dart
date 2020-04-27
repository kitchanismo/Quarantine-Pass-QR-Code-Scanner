import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/screens/home.dart';
import 'package:qr_checker/screens/signin.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return user == null ? SignIn() : Home();
  }
}
