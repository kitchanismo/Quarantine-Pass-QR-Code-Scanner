import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'package:qr_checker/common/loading.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/models/scan.dart';
import 'package:qr_checker/services/scan_service.dart';
import 'package:qr_checker/utils/helper.dart';

class Found extends StatefulWidget {
  // static const routeName = '/found';

  @override
  _FoundState createState() => _FoundState();
}

class _FoundState extends State<Found> {
  bool isIDSwitched = true;
  bool isMaskSwitched = true;
  ScanService scanService = ScanService();

  @override
  Widget build(BuildContext context) {
    final Passer passer = ModalRoute.of(context).settings.arguments;
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/people.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.white.withOpacity(0.9),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.teal, //change your color here
              ),
              backgroundColor: Colors.transparent,
              title: Text('Information Details',
                  style: TextStyle(color: Colors.teal)),
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(children: <Widget>[
                    buildQRCode(context: context, code: passer.code),
                    buildToggles(passer.code),
                  ]),
                ),
                buildDetails(passer),
              ],
            )),
      ],
    );
  }

  Widget buildDetails(Passer passer) {
    Widget detail({String label, String text, Widget child}) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Wrap(
          children: <Widget>[
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 20)),
            SizedBox(
              width: 5,
            ),
            child != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: child,
                  )
                : Text('')
          ],
        ),
        Text(text,
            maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 25)),
        SizedBox(
          height: 20,
        ),
      ]);
    }

    Widget renderIcon() {
      if (Helper.isPassValid(passer.validity)) {
        return Icon(
          Icons.verified_user,
          color: Colors.white,
        );
      }
      return Icon(
        FontAwesome.times,
        color: Colors.pinkAccent,
      );
    }

    // final detailsHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                detail(label: 'Fullname', text: passer.name),
                detail(label: 'Address', text: passer.address),
                detail(
                    label: 'Validity',
                    text: Helper.dateOnly(passer.validity),
                    child: renderIcon()),
                buildButtons(passer)
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      ),
    );
  }

  Widget buildButtons(Passer passer) {
    var isPassed =
        isMaskSwitched && isIDSwitched && Helper.isPassValid(passer.validity);

    void onSave() async {
      Scan scan =
          Scan(name: passer.name, code: passer.code, address: passer.address);
      EasyLoading.show(status: 'saving...');
      final res = await scanService.add(scan);
      EasyLoading.dismiss();
      if (res) {
        EdgeAlert.show(
          context,
          title: 'QR SCANNER',
          description: 'Successfully Saved!',
          backgroundColor: Colors.green,
          gravity: EdgeAlert.TOP,
          duration: EdgeAlert.LENGTH_SHORT,
        );

        Navigator.pushNamed(context, '/');
        return;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MyButton(
                onPressed: isPassed ? onSave : null,
                child: Text(isPassed ? 'PASS' : 'UNAUTHORIZED',
                    style: TextStyle(color: Colors.white, fontSize: 20))),
          ),
        ],
      ),
    );
  }

  Widget buildToggles(String code) {
    return Expanded(
      child: Container(
          //padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
          decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                code,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              buildSwitch(
                  label: 'Valid ID',
                  isSwitched: isIDSwitched,
                  onChanged: (value) => setState(() => isIDSwitched = value)),
              buildSwitch(
                  label: 'Face Mask',
                  isSwitched: isMaskSwitched,
                  onChanged: (value) => setState(() => isMaskSwitched = value)),
            ],
          )),
    );
  }

  Widget buildSwitch({bool isSwitched, String label, Function onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: TextStyle(
                color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold)),
        Switch(
          value: isSwitched,
          onChanged: onChanged,
          activeColor: Colors.green,
        ),
      ]),
    );
  }

  Widget buildQRCode({BuildContext context, String code}) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.transparent),
      child: PrettyQr(
          typeNumber: 1,
          data: code,
          size: 130,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          roundEdges: true),
    );
  }
}
