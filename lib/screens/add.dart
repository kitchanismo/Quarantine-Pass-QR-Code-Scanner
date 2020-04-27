import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:qr_checker/utils/helper.dart';
import 'package:short_readable_id/short_readable_id.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/common/my_textfield.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  Passer passer =
      Passer(code: '', name: '', address: '', validity: DateTime.now());
  String code;

  @override
  void initState() {
    code = idGenerator.generateReadable();
    passer.code = code;
    super.initState();
  }

  void onContinue() {
    if (passer.code == '' || passer.name == '' || passer.address == '') {
      EdgeAlert.show(
        context,
        icon: FontAwesome.times,
        title: 'Invalid Input',
        description: 'Fill-up all the fields.',
        backgroundColor: Colors.pinkAccent,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_LONG,
      );
      return;
    }
    Navigator.pushNamed(context, '/preview', arguments: passer);
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
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Wrap(direction: Axis.vertical, children: <Widget>[
                    Text('VALIDITY',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Helper.dateOnly(passer.validity),
                        style: TextStyle(color: Colors.teal, fontSize: 25))
                  ]),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(
                        FontAwesome.calendar,
                        size: 40,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        _showDatePicker();
                      }),
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                onPressed: onContinue,
                child: Text('CONTINUE',
                    style: TextStyle(fontSize: 18, color: Colors.white)))
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        // showTitle: _showTitle,
        confirm:
            Text('Confirm', style: TextStyle(color: Colors.teal, fontSize: 20)),
        cancel: Text('Cancel', style: TextStyle(fontSize: 20)),
      ),
      minDateTime: DateTime.now(),
      // maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: passer.validity,

      onChange: (dateTime, List<int> index) {
        setState(() {
          passer.validity = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          passer.validity = dateTime;
        });
      },
    );
  }
}
