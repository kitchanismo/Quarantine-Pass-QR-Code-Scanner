import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_checker/common/loading.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'package:qr_checker/services/passer_service.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:qr_checker/utils/helper.dart';

class Preview extends StatefulWidget {
  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  final passerService = PasserService();

  Future onSave(Passer passer) async {
    EasyLoading.show(status: 'saving...');

    final res = await passerService.add(passer);
    EasyLoading.dismiss();
    if (res) {
      EdgeAlert.show(
        context,
        title: 'QR SCANNER',
        description: 'Successfully Added!',
        backgroundColor: Colors.green,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_LONG,
      );
      Navigator.pushNamed(context, '/');
      return;
    }
    EdgeAlert.show(
      context,
      title: 'QR SCANNER',
      description: 'Error Occured!',
      backgroundColor: Colors.pinkAccent,
      gravity: EdgeAlert.TOP,
      duration: EdgeAlert.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    Passer passer = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(elevation: 0, title: Text('Preview')),
        body: Container(
            child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildQRCode(context: context, code: passer.code),
            ]),
            buildCard(passer, context),
          ],
        )));
  }

  Widget buildCard(Passer passer, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // Text(passer.code, style: TextStyle(fontSize: 30)),

      Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(color: Colors.teal),
          child: Center(
            child: Text(passer.code,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          )),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildText(text: passer.name, label: 'NAME'),
            buildText(text: passer.address, label: 'ADDRESS'),
            buildText(
                text: Helper.dateOnly(passer.validity), label: 'VALIDITY'),
            MyButton(
                onPressed: () async => await onSave(passer),
                child: Text('SAVE',
                    style: TextStyle(color: Colors.white, fontSize: 20)))
          ],
        ),
      )
    ]);
  }

  // Future<void> _neverSatisfied(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('QR SCANNER'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Succesfully added!'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           MyButton(
  //             child: Text('Ok',
  //                 style: TextStyle(fontSize: 15, color: Colors.white)),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget buildText({String text, String label}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: TextStyle(fontSize: 20)),
        Text(text,
            style: TextStyle(
                fontSize: 25, color: Colors.teal, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget buildQRCode({BuildContext context, String code}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: PrettyQr(

            // image: AssetImage('images/twitter.png'),
            typeNumber: 1,
            size: MediaQuery.of(context).size.width - 50,
            data: code,
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true),
      ),
    );
  }
}
