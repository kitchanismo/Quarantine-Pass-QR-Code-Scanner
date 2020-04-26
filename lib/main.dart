import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:qr_checker/app.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/services/auth_service.dart';
import 'package:qr_checker/services/passer_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final user = AuthService().user;

  //print(user);
  runApp(MultiProvider(
    providers: [
      StreamProvider<User>(
        create: (_) => user,
        initialData: null,
      ),
      //prevent fetching passers when not login
      // ProxyProvider<User, List<Passer>>(
      //   update: (_, user, __) {

      //     return Stream(
      //       initialData: [],
      //       stream: PasserService().fetchPassers(),
      //       builder: (ctx,snapshot)=>snapshot.data);
      //   },
      // ),
    ],
    child: MyApp(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.red
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 60.0
    ..radius = 10.0
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..contentPadding = EdgeInsets.all(40)
    ..userInteractions = false;
}
