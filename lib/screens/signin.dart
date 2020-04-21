import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:qr_checker/common/loading.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/services/auth_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:qr_checker/utils/teddy_controller.dart';
import 'package:qr_checker/common/tracking_text_input.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TeddyController _teddyController;
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  final auth = AuthService();
  User user = User();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Loading(
      isLoading: isLoading,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/covid.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
              backgroundColor: Color.fromRGBO(0, 128, 128, 0.9),
              body: Container(
                child: ListView(padding: EdgeInsets.only(top: 0), children: [
                  buildBanner(
                      context: context,
                      child: Form(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 5),
                                      child: Text('Welcome',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.teal)),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    TrackingTextInput(
                                        // initialValue: user.email,
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
                                        // initialValue: user.password,
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        MyButton(
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            final result =
                                                await auth.signIn(user);

                                            print(result.item1);
                                            if (result.item2 == false) {
                                              EdgeAlert.show(
                                                context,
                                                icon: Icons.close,
                                                title: 'QR SCANNER',
                                                description: result.item1,
                                                backgroundColor:
                                                    Colors.pinkAccent,
                                                gravity: EdgeAlert.TOP,
                                                duration:
                                                    EdgeAlert.LENGTH_VERY_LONG,
                                              );
                                              await _teddyController.fail();

                                              setState(() {
                                                isLoading = false;
                                              });
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
                                            // _teddyController.success();

                                            // Navigator.pushNamed(context, '/');
                                          },
                                          child: Text('SIGN IN',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      ))),
                ]),
              )),
        ],
      ),
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
              padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
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