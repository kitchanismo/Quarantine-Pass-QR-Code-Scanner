import 'package:flutter/material.dart';
import 'package:twitter_qr_scanner/twitter_qr_scanner.dart';
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
  var qrText = "";

  @override
  void initState() {
    super.initState();
  }

  void foundCode(String scanData) {
    setState(() {
      print("QRCode: $scanData");
    });
    controller.pauseCamera();
    Navigator.pushReplacementNamed(context, '/foundCode',
        arguments: {'code': scanData});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
              borderRadius: 16,
              borderColor: Colors.white,
              borderLength: 120,
              borderWidth: 10,
              cutOutSize: 250),
          onQRViewCreated: _onQRViewCreate,
          data: "QR TEXT",
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
