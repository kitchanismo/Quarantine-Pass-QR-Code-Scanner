import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/services/auth_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:qr_checker/custom/teddy_controller.dart';
import 'package:qr_checker/common/tracking_text_input.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TeddyController _teddyController;
  AuthService auth;
  User user;

  @override
  initState() {
    auth = AuthService();
    user = User(email: '', password: '');
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  bool isInputValid() {
    if (user.email == '' || user.password == '') {
      EdgeAlert.show(
        context,
        icon: Icons.notifications,
        title: 'Invalid Input',
        description: 'Fill-up all the fields.',
        backgroundColor: Colors.pinkAccent,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_LONG,
      );
      _teddyController.fail();
      return false;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email);

    if (!emailValid) {
      EdgeAlert.show(
        context,
        icon: Icons.notifications,
        title: 'Invalid Input',
        description: 'Email is in invalid format!',
        backgroundColor: Colors.pinkAccent,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_LONG,
      );
      _teddyController.fail();
      return false;
    }
    return true;
  }

  void onSubmit() async {
    if (!isInputValid()) {
      return;
    }

    EasyLoading.show(status: 'signing in...');

    final result = await auth.signIn(user);

    EasyLoading.dismiss();
    if (result.item2 == false) {
      EdgeAlert.show(
        context,
        icon: FontAwesome.times,
        title: 'QR SCANNER',
        description: result.item1,
        backgroundColor: Colors.pinkAccent,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_VERY_LONG,
      );
      _teddyController.fail();

      //await Future.delayed(Duration(seconds: 2));
      return;
    }
    EdgeAlert.show(
      context,
      icon: Icons.check,
      title: 'QR SCANNER',
      description: result.item1,
      backgroundColor: Colors.green,
      gravity: EdgeAlert.TOP,
      duration: EdgeAlert.LENGTH_LONG,
    );

    _teddyController.success();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/people.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Color.fromRGBO(0, 128, 128, 0.9),
            body: Container(
              child: ListView(children: [
                buildBanner(
                    context: context,
                    child: Form(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, .9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  TrackingTextInput(
                                      label: "Email",
                                      onTextChanged: (value) {
                                        setState(() {
                                          user.email = value;
                                        });
                                      },
                                      onCaretMoved: (Offset caret) {
                                        _teddyController.lookAt(caret);
                                      }),
                                  TrackingTextInput(
                                      label: "Password",
                                      isObscured: true,
                                      onCaretMoved: (Offset caret) {
                                        _teddyController
                                            .coverEyes(caret != null);
                                        _teddyController.lookAt(null);
                                      },
                                      onTextChanged: (String value) {
                                        _teddyController.setPassword(value);
                                        setState(() {
                                          user.password = value;
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        MyButton(
                                          onPressed: onSubmit,
                                          child: Text('SIGN IN',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ))),
              ]),
            )),
      ],
    );
  }

  Widget buildBanner({Widget child, BuildContext context}) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 15, 0),
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: FlareActor("assets/ted.flr",
                  alignment: Alignment.center,
                  shouldClip: false,
                  fit: BoxFit.fill,
                  controller: _teddyController),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
