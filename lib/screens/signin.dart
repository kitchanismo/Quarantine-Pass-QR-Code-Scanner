import 'package:flutter/material.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/common/my_textField.dart';
import 'package:qr_checker/models/user.dart';
import 'package:qr_checker/services/auth_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final auth = AuthService();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    child: Form(
                        child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MyTextField(
                          textColor: Colors.white,
                          label: Text('EMAIL',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white60,
                              )),
                          onChanged: (value) {
                            setState(() {
                              user.email = value;
                            });
                          },
                        ),
                        MyTextField(
                          obscureText: true,
                          textColor: Colors.white,
                          label: Text('PASSWORD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white60,
                                  fontSize: 20)),
                          onChanged: (value) {
                            setState(() {
                              user.password = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: () async {
                            final result = await auth.signIn(user);
                            print(result);
                            if (result.item2 == true) {
                              Navigator.pushNamed(context, '/');
                              return;
                            }

                            print(result.item1);
                            //
                          },
                          child: Text('SIGN IN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        )
                      ]),
                ))),
              ]),
            )),
      ],
    );
  }

  Widget buildBanner({Widget child}) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 300,
              color: Colors.white,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
