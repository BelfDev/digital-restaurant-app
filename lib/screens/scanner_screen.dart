import 'package:dr_app/components/buttons/icon_button.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  static const id = "scanner_screen";
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
                borderColor: LUColors.smoothWhite,
                borderRadius: 8,
                borderLength: 40,
                borderWidth: 12,
                cutOutSize: 240,
                cutOutBottomOffset: 140),
            onQRViewCreated: _onQRViewCreated,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: LUIconButton(
                icon: Icons.close,
                backgroundColor: LUColors.smoothWhite,
                iconSize: 32,
                tint: LUColors.navyBlue,
                onPressed: () => Navigator.of(context).pop()),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
