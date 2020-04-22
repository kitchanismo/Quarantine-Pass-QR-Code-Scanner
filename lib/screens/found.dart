import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/utils/helper.dart';

class Found extends StatefulWidget {
  // static const routeName = '/found';

  @override
  _FoundState createState() => _FoundState();
}

class _FoundState extends State<Found> {
  bool isIDSwitched = false;
  bool isMaskSwitched = false;
  @override
  Widget build(BuildContext context) {
    final Passer passer = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.teal, //change your color here
          ),
          backgroundColor: Colors.white,
          title:
              Text('Information Details', style: TextStyle(color: Colors.teal)),
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
            buildDetails(passer)
          ],
        ));
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
                    padding: const EdgeInsets.only(top: 5),
                    child: child,
                  )
                : Text('')
          ],
        ),
        Text(text,
            maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 25)),
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

    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            detail(label: 'Fullname', text: passer.name),
            detail(label: 'Address', text: passer.address),
            detail(
                label: 'Validity',
                text: Helper.dateOnly(passer.validity),
                child: renderIcon()),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      ),
    );
  }

  Widget buildToggles(String code) {
    return Expanded(
      child: Container(
          // padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
          decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          label,
          style: TextStyle(color: Colors.teal, fontSize: 20),
        ),
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
          color: Colors.white),
      child: PrettyQr(
          typeNumber: 1,
          data: code,
          size: 130,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          roundEdges: true),
    );
  }
}
