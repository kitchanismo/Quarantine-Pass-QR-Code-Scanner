import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_checker/app.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/services/auth_service.dart';
import 'package:qr_checker/services/passer_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
      StreamProvider<User>.value(value: AuthService().user),
      ChangeNotifierProvider<PasserService>.value(value: PasserService()),
    ],
    child: MyApp(),
  ));
}
