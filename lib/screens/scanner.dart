import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:qr_checker/services/passer_service.dart';
import 'package:qr_checker/utils/QRCustom.dart';

///import 'package:twitter_qr_scanner/twitter_qr_scanner.dart';
import 'package:twitter_qr_scanner/QrScannerOverlayShape.dart';

class Scanner extends StatefulWidget {
  Scanner({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  GlobalKey qrKey = GlobalKey();
  QRViewController controller;
  PasserService passerService = PasserService();

  var qrText = "";
  @override
  void initState() {
    this.controller?.resumeCamera();
    super.initState();
  }

  void foundCode(String scanData) async {
    setState(() {
      print("QRCode: $scanData");
      qrText = scanData;
    });

    EasyLoading.show(status: 'checking...');

    controller.pauseCamera();

    Passer passer = await passerService.isCodeValid(scanData);
    EasyLoading.dismiss();
    if (passer != null) {
      EdgeAlert.show(
        context,
        icon: Icons.verified_user,
        title: 'QR SCANNER',
        description: 'QR Code found!',
        backgroundColor: Colors.green,
        gravity: EdgeAlert.TOP,
        duration: EdgeAlert.LENGTH_SHORT,
      );

      Navigator.pushReplacementNamed(context, '/found', arguments: passer);
      return;
    }

    EdgeAlert.show(
      context,
      icon: FontAwesome.times,
      title: 'QR SCANNER',
      description: 'QR Code not found!',
      backgroundColor: Colors.pinkAccent,
      gravity: EdgeAlert.TOP,
      duration: EdgeAlert.LENGTH_LONG,
    );

    this.controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: QRCustom(
          onPageChanged: (index) {
            index == 1
                ? this.controller.pauseCamera()
                : this.controller.resumeCamera();
          },
          onFlashOn: () => this.controller.toggleFlash(),
          key: qrKey,
          switchButtonColor: Colors.pinkAccent,
          overlay: QrScannerOverlayShape(
              borderRadius: 16,
              borderColor: Colors.teal,
              borderLength: 120,
              borderWidth: 5,
              cutOutSize: 250),
          onQRViewCreated: _onQRViewCreate,
          data: qrText,
        ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      foundCode(scanData);
    });
  }
}
