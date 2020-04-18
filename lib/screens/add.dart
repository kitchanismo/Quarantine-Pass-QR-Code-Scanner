import 'package:flutter/material.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/common/my_textfield.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final passers = Passer(code: '', name: '', address: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD FORM')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Form(
          child: Column(
            children: <Widget>[
              MyTextField(
                label: 'CODE',
                onChanged: (value) {
                  setState(() {
                    passers.code = value;
                  });
                },
              ),
              MyTextField(
                label: 'FULLNAME',
                onChanged: (value) {
                  setState(() {
                    passers.name = value;
                  });
                },
              ),
              MyTextField(
                label: 'ADDRESS',
                onChanged: (value) {
                  setState(() {
                    passers.address = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                  onPressed: () {},
                  child: Text('SAVE',
                      style: TextStyle(fontSize: 18, color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
