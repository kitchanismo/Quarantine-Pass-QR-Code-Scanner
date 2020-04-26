library twitter_qr_scanner;

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

typedef void QRViewCreatedCallback(QRViewController controller);

enum QRMode { SCANNER, VIEWER }

class QRCustom extends StatefulWidget {
  const QRCustom(
      {@required Key key,
      @required this.onQRViewCreated,
      @required this.data,
      this.overlay,
      this.initialMode = QRMode.SCANNER,
      this.qrCodeBackgroundColor = Colors.blue,
      this.qrCodeForegroundColor = Colors.white,
      this.switchButtonColor = Colors.white,
      this.onFlashOn,
      this.onPageChanged})
      : assert(key != null),
        assert(onQRViewCreated != null),
        assert(data != null),
        super(key: key);

  final QRViewCreatedCallback onQRViewCreated;

  final ShapeBorder overlay;
  final String data;
  final Color qrCodeBackgroundColor;
  final Color qrCodeForegroundColor;
  final Color switchButtonColor;
  final QRMode initialMode;
  final Function onPageChanged;
  final Function onFlashOn;

  @override
  State<StatefulWidget> createState() => _QRCustomState();
}

class _QRCustomState extends State<QRCustom> {
  bool isScanMode = false;
  CarouselSlider slider;
  var flareAnimation = "view";

  @override
  void initState() {
    isScanMode = widget.initialMode == QRMode.SCANNER;

    super.initState();
  }

  bool isFlashOn = false;

  getSlider() {
    setState(() {
      slider = CarouselSlider(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        initialPage: widget.initialMode == QRMode.SCANNER ? 0 : 1,
        onPageChanged: widget.onPageChanged,
        items: [
          Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: widget.overlay,
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: widget.overlay,
            ),
            child: Container(
              width: 240,
              height: 240,
              padding: EdgeInsets.all(21),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.qrCodeBackgroundColor,
              ),
              child: QrImage(
                data: widget.data,
                version: QrVersions.auto,
                foregroundColor: widget.qrCodeForegroundColor,
                gapless: true,
              ),
            ),
          ),
        ],
      );
    });
    return slider;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getPlatformQrView(),
        getSlider(),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: IconButton(
              icon: Icon(Icons.stop, color: Colors.pinkAccent, size: 50),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: IconButton(
              icon: Icon(FontAwesome.bolt,
                  color: isFlashOn ? Colors.yellowAccent : Colors.white,
                  size: 30),
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                widget.onFlashOn();
              },
            ),
          )),
        ),
      ],
    );
  }

  Widget _getPlatformQrView() {
    Widget _platformQrView;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        _platformQrView = AndroidView(
          viewType: 'com.anka.twitter_qr_scanner/qrview',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
        break;
      case TargetPlatform.iOS:
        _platformQrView = UiKitView(
          viewType: 'com.anka.twitter_qr_scanner/qrview',
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: _CreationParams.fromWidget(0, 0).toMap(),
          creationParamsCodec: StandardMessageCodec(),
        );
        break;
      default:
        throw UnsupportedError(
            "Trying to use the default webview implementation for $defaultTargetPlatform but there isn't a default one");
    }
    return _platformQrView;
  }

  void _onPlatformViewCreated(int id) async {
    if (widget.onQRViewCreated == null) {
      return;
    }
    widget.onQRViewCreated(QRViewController._(id, widget.key));
  }
}

class _CreationParams {
  _CreationParams({this.width, this.height});

  static _CreationParams fromWidget(double width, double height) {
    return _CreationParams(
      width: width,
      height: height,
    );
  }

  final double width;
  final double height;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
    };
  }
}

class QRViewController {
  static const scanMethodCall = "onRecognizeQR";

  final MethodChannel _channel;

  StreamController<String> _scanUpdateController = StreamController<String>();

  Stream<String> get scannedDataStream => _scanUpdateController.stream;

  QRViewController._(int id, GlobalKey qrKey)
      : _channel = MethodChannel('com.anka.twitter_qr_scanner/qrview_$id') {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final RenderBox renderBox = qrKey.currentContext.findRenderObject();
      _channel.invokeMethod("setDimensions",
          {"width": renderBox.size.width, "height": renderBox.size.height});
    }
    _channel.setMethodCallHandler(
      (MethodCall call) async {
        switch (call.method) {
          case scanMethodCall:
            if (call.arguments != null) {
              _scanUpdateController.sink.add(call.arguments.toString());
            }
        }
      },
    );
  }

  void flipCamera() {
    _channel.invokeMethod("flipCamera");
  }

  void toggleFlash() {
    _channel.invokeMethod("toggleFlash");
  }

  void pauseCamera() {
    _channel.invokeMethod("pauseCamera");
  }

  void resumeCamera() {
    _channel.invokeMethod("resumeCamera");
  }

  void dispose() {
    _scanUpdateController.close();
  }
}
