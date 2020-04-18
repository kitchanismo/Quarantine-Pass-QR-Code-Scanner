import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_checker/services/passer_service.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/common/my_textfield.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final passer = Passer(code: '', name: '', address: '');

  @override
  Widget build(BuildContext context) {
    final passerService = Provider.of<PasserService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ADD FORM')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Form(
          child: ListView(
            children: <Widget>[
              MyTextField(
                label: 'CODE',
                onChanged: (value) {
                  setState(() {
                    passer.code = value;
                  });
                },
              ),
              MyTextField(
                label: 'FULLNAME',
                onChanged: (value) {
                  setState(() {
                    passer.name = value;
                  });
                },
              ),
              MyTextField(
                label: 'ADDRESS',
                onChanged: (value) {
                  setState(() {
                    passer.address = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                  onPressed: () {
                    passerService.add(passer);
                  },
                  child: Text('SAVE',
                      style: TextStyle(fontSize: 18, color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
