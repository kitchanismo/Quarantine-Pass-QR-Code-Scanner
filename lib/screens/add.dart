import 'package:flutter/material.dart';
import 'package:short_readable_id/short_readable_id.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/common/my_textfield.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  Passer passer = Passer(code: '', name: '', address: '');
  String code;

  @override
  void initState() {
    code = idGenerator.generateReadable();
    passer.code = code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final passerService = Provider.of<PasserService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ADD FORM')),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          children: <Widget>[
            MyTextField(
              readOnly: true,
              initialValue: code,
              label: Text('CODE',
                  style: TextStyle(color: Colors.grey[700], fontSize: 20)),
              onChanged: (value) {
                setState(() {
                  passer.code = value;
                });
              },
            ),
            MyTextField(
              label: Text('FULLNAME',
                  style: TextStyle(color: Colors.grey[700], fontSize: 20)),
              onChanged: (value) {
                setState(() {
                  passer.name = value;
                });
              },
            ),
            MyTextField(
              label: Text('ADDRESS',
                  style: TextStyle(color: Colors.grey[700], fontSize: 20)),
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
                  // passerService.add(passer);
                  Navigator.pushNamed(context, '/preview', arguments: passer);
                },
                child: Text('CONTINUE',
                    style: TextStyle(fontSize: 18, color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
