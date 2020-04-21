import 'package:flutter/material.dart';
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
  return runApp(MultiProvider(
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
}
